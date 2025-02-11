function [dSbus_dV1,dSbus_dV2] = dSbus_dV(Ybus, V)
%% MATLAB implementation of dSbus_dV function.
    % Inputs:
    %   Ybus: System admittance matrix
    %   V: Bus voltage vector
    % Outputs:
    %   dSbus_dV1: Partial derivative of Sbus w.r.t. the first variable
    %   dSbus_dV2: Partial derivative of Sbus w.r.t. the second variable
%%
    Ibus = Ybus * V;
    diagV = diag(V);% Diagonal matrix of voltages
    diagIbus = diag(Ibus);% Diagonal matrix of currents
    diagVnorm =diag(V ./ abs(V));% Diagonal matrix of normalized voltages
    dSbus_dV1 = 1i * diagV * conj(diagIbus - Ybus * diagV);  % dSbus/dVa
    dSbus_dV2 = diagV * conj(Ybus * diagVnorm) + conj(diagIbus) * diagVnorm;  % dSbus/dVm
end