%% This function is designed to modify the adimittance matrix after a fault
% The location is defined by the fault_line_FBUS and fault_line_TBUS, it
% choose the fault branch.If there are two or more branches connected to
% the two buses,the default option is choose the first line in the case.
function [Ybus,Yfault]=fault_modify_admittance(fault_closed_bus,Ybus,Y0)
    Ybus=Ybus+diag(Y0); %Add the load to the admittance matrix
    Yfault=Ybus(fault_closed_bus,fault_closed_bus);
    Ybus(fault_closed_bus,fault_closed_bus)=10^20;
end