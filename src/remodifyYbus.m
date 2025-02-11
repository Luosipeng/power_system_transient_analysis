%% This function is designed to modify the admittance matri because of the fault has been removed
function Ybus=remodifyYbus(mpc,Ybus,Yfault,fault_line_FBUS,fault_line_TBUS,fault_closed_bus,duplicate_pairs)
    F=fault_line_FBUS;
    T=fault_line_TBUS;
    %% Error output
    if F>T
        error('fault_line_FBUS的值必须小于fault_line_TBUS')
    end
    
    %% Modify the admitance element
    Ybus(fault_closed_bus,fault_closed_bus)=Yfault;
    %% Parallel line detect
    is_present = any(ismember(duplicate_pairs, [F, T], 'rows'));%find whether Fbus and Tbus connected branch is a parallel line
    if is_present
        %This section can only handle lines composed of two identical lines
        %connected in parallel 
        Ybus(F,T)=0.5*Ybus(F,T);
        Ybus(T,F)=0.5*Ybus(T,F);
        branch_index=find((mpc.branch(:,1) == F) & (mpc.branch(:,2) == T));
        Ybus(F,F)=Ybus(F,F)-0.5/(mpc.branch(branch_index,3)+1i*mpc.branch(branch_index,4))-0.25*1i*mpc.branch(branch_index,5);
        Ybus(T,T)=Ybus(T,T)-0.5/(mpc.branch(branch_index,3)+1i*mpc.branch(branch_index,4))-0.25*1i*mpc.branch(branch_index,5);
    else
    Ybus(F,T)=0;
    Ybus(T,F)=0;
    branch_index=find((mpc.branch(:,1) == F) & (mpc.branch(:,2) == T));
    Ybus(F,F)=Ybus(F,F)-1/(mpc.branch(branch_index,3)+1i*mpc.branch(branch_index,4))-0.5*1i*mpc.branch(branch_index,5);
    Ybus(T,T)=Ybus(T,T)-1/(mpc.branch(branch_index,3)+1i*mpc.branch(branch_index,4))-0.5*1i*mpc.branch(branch_index,5);
    end
end