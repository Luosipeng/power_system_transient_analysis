%% This function is designed for power system transient stability analysis
%The numerical integration method adopts an improved Euler method
function [omega,delta,omega_store,delta_store,Pe_store]=transient_analysis(mpc,Cg,Pm0,omega0,delta0,Ybus,Eq_trans,V0,I0,Yfault,fault_line_FBUS,fault_line_TBUS,fault_closed_bus,duplicate_pairs)
    %Call indexing function
    index_geninfo=idx_geninfo();
    %Define generator impedance parameter
    Ra=mpc.geninfo(:,index_geninfo.RA);
    Xq=mpc.geninfo(:,index_geninfo.XQ);
    Xd_trans=mpc.geninfo(:,index_geninfo.XDT);
    V=V0;
    I=I0;
    Vx=real(V);
    Vy=imag(V);
    Ix=real(I);
    Iy=imag(I);
    %% Initialize 
    t=0;
    h=0.001;%Steps
    T1=0.08333;%Total time
    T=2;
    N=int32(T/h);%iteration times
    N1=int32(T1/h);
    Pm=Pm0;
    omega=omega0;
    delta=delta0;
    Tj=mpc.geninfo(:,2);
    it=0;
    end_flag=1;
    %Define storage vector
    
    omega_store=zeros(size(mpc.gen,1),N);
    delta_store=zeros(size(mpc.gen,1),N);
    Pe_store=zeros(size(mpc.gen,1),N);
    omega_store(:,1)=omega;
    delta_store(:,1)=delta;
    
    while(end_flag)
        %% Step1:Calculate the next states variables
        Pe=(Vx(Cg).*Ix+Vy(Cg).*Iy)+(Ix.^2+Iy.^2).*Ra;
        delta_next=delta+h*(omega-1)*2*pi*60;
        omega_next=omega+h*(Pm-Pe)./Tj;
        %% Step2:Calculate the injected circuit
        %bx=(Ra.*cos(delta_next)+Xq.*sin(delta_next))./(Ra.^2+Xd_trans.*Xq);
        %gy=(Ra.*sin(delta_next)-Xq.*cos(delta_next))./(Ra.^2+Xd_trans.*Xq);
        I=Eq_trans.*exp(1i*delta_next)./(Ra+1i*Xd_trans);
        Ix=real(I);
        Iy=imag(I);
        I0=zeros(size(mpc.bus,1),1);
        I0(Cg)=I;
        %% Step3:Calculate the control variables --voltage
        %Recalculate Ybus
        [V,Ybus_expand]=recalculateV(mpc,delta_next,Ybus,I0,Cg);
        %Y(7,7)=10^20;
        %V=Y^-1*I0;
        %V=(Ybus)^-1*I0;
        Vx=real(V);
        Vy=imag(V);
        %% Step4:Calculate the next states variables
        Pe_next=(Vx(Cg).*Ix+Vy(Cg).*Iy)+(Ix.^2+Iy.^2).*Ra;
        %delta_next=delta+h*(omega_next-1)*2*pi*50;
        %omega_next=omega+h*(Pm-Pe_next)./Tj;
        %% Step5:Calculate the final value
        delta_k=delta+0.5*h*((omega-1)*2*pi*60+(omega_next-1)*2*pi*60);
        omega_k=omega+0.5*h*((Pm-Pe)./Tj+(Pm-Pe_next)./Tj);
        delta=delta_k;
        omega=omega_k;
        it=it+1;
        if it==N1%Remove the fault
            %Remodifiy the admittance matrix
            Ybus=remodifyYbus(mpc,Ybus,Yfault,fault_line_FBUS,fault_line_TBUS,fault_closed_bus,duplicate_pairs);
            [V,Ybus_expand]=recalculateV(mpc,delta,Ybus,I0,Cg);
            Vx=real(V);
            Vy=imag(V);
        end
        if it==N
            end_flag=0;
        end
        %Storage
        omega_store(:,it)=omega;
        delta_store(:,it)=delta;
        Pe_store(:,it)=Pe;
    end
end