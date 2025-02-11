%% This script is aim to analysis the load flow and return the initial data for transient analysis
%The author:Sipeng Luo
%Student ID:3124104203
%Date:2024.12.14
%The input data format is modified IEEE format
%The input cases are case_9bus_system and case_3bus_system, where
%case_3bus_system is also a single machine infinite bus system.
%
%This Power flow analysis script transfer the bus type from PV bus to PQ
%bus when the reactive power is out of limit 
%% Initialize 
%TODO:Complete the conversion from PV node to PQ node
Qlim_flag=0;%1 - Transfering the bus type from PV bus to PQ bus when the reactive power is out of limit 
Option=settings();
%% Input Data
mpc=case_9bus_system();%Choose the case data
bus=mpc.bus;
branch=mpc.branch;
gen=mpc.gen;
baseMVA=mpc.baseMVA;
%% Choose the loacation of the fault
fault_line_FBUS=5;
fault_line_TBUS=7;
fault_closed_bus=7;
%% Define index of generator,bus and branch
index_bus=idx_bus();%Index for bus matrix
index_branch=idx_brch();%Index for branch matrix
index_gen=idx_gen();%Index for generator matrix
index_geninfo=idx_geninfo();
Ra=mpc.geninfo(:,index_geninfo.RA);
Xq=mpc.geninfo(:,index_geninfo.XQ);
Xd_trans=mpc.geninfo(:,index_geninfo.XDT);
%% Search the in-serviced generator
on=gen(:, index_gen.GEN_STATUS) == 1;%Search in-serviced generator
gen=gen(on,:);%Only keep the in-serviced generator
Cg=gen(:,index_gen.GEN_BUS );%Find the connected bus of this generator
%Create a sparse matrix for injected power to allocate
nb=size(bus,1);
nc=length(Cg);
Cg_matrix = sparse(Cg, 1:nc, 1, nb, nc);
%% Detect the bus type
[ref,pq,pv]=bustype(gen,bus);
%% Calculate the admittance matrix
[branch,duplicate_pairs]=parallelbrch(branch);%preoperation on branches
[bus,gen,branch]=ext2int(bus, gen, branch);%Convert the data from external format to internal format 
[Ybus,Yf,Yt]=makeYbus(baseMVA,bus,branch);
%% Run Newton power flow
repeat=1;
its=0;
while(repeat)
    [V, success, iterations]=newtonpf(bus,gen,branch,Ybus,ref,pv,pq,Cg_matrix,baseMVA,Option.PF_TOL,Option.PF_MAX_IT,Option.NR_ALG);
    its=its+1;
    %update data matrices with solution
    [bus, gen, branch]=pfsoln(baseMVA, bus, gen, branch, Ybus, Yf, Yt, V, ref, pv, pq);
    repeat=0;
end
%%  -----  output power flow results  -----
%convert back to original bus numbering & print results
mpc.bus=bus;
mpc.gen=gen;
mpc.branch=branch;
mpc.iterations= its;
fprintf('Running Power Flow Analysis Successfully\n');
%print(mpc["bus"],its);
    
%% Calculate the initial control value
[delta0,omega0,Eq_trans,Y0,Pm0,Pe0,V0,I0]=calculate_initial_value(mpc,Cg,baseMVA);
%% Fault in the power system
fprintf('Fault in the power system\n');
fprintf('The fault type should be short circuit\n')

%% Modify the admittance after fault
[Ybus,Yfault]=fault_modify_admittance(fault_closed_bus,Ybus,Y0);
I0=Eq_trans.*exp(1i*delta0)./(Ra+1i*Xd_trans);
I=zeros(size(mpc.bus,1),1);
I(Cg)=I0;
[V0,Ybus_expand]=recalculateV(mpc,delta0,Ybus,I,Cg);
[omega,delta,omega_store,delta_store,Pe_store]=transient_analysis(mpc,Cg,Pm0,omega0,delta0,Ybus,Eq_trans,V0,I0,Yfault,fault_line_FBUS,fault_line_TBUS,fault_closed_bus,duplicate_pairs);
delta_store=delta_store*180/pi;
%% Relative swing angle
Relative_delta=delta_store(2,:)-delta_store(1,:);
%% Plot figure
plot_generator_data(mpc, delta_store, omega_store, Pe_store)

% figure
% plot(Relative_delta1,'DisplayName', '\Delta (\delta_2 - \delta_1)(ct=0.162s)')
% hold on
% plot(Relative_delta,'DisplayName', '\Delta (\delta_2 - \delta_1)(ct=0.163s)')
% xlabel('Time Steps');
% ylabel('Relative Delta (\delta)');
% title('Relative Swing Angle');
% legend('show');
% grid on;