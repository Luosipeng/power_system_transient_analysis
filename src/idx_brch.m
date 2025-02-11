function branch_data =idx_brch()
   %% Define the indices
    branch_data.F_BUS       = 1;    % f, from bus number
    branch_data.T_BUS       = 2;    % t, to bus number
    branch_data.BR_R        = 3;    % r, resistance (p.u.)
    branch_data.BR_X        = 4;    % x, reactance (p.u.)
    branch_data.BR_B        = 5;    % b, total line charging susceptance (p.u.)
    branch_data.RATE_A      = 6;    % rateA, MVA rating A (long term rating)
    branch_data.RATE_B      = 7;    % rateB, MVA rating B (short term rating)
    branch_data.RATE_C      = 8;    % rateC, MVA rating C (emergency rating)
    branch_data.TAP         = 9;    % ratio, transformer off nominal turns ratio
    branch_data.SHIFT       = 10;   % angle, transformer phase shift angle (degrees)
    branch_data.BR_STATUS   = 11;   % initial branch status, 1 - in service, 0 - out of service
    branch_data.BRANCHMODE  = 12;
    branch_data.PC        = 13;
    branch_data.QC        = 14;
    branch_data.ETACR       = 15;
    branch_data.ETACI       = 16;
    branch_data.PHI         = 17;
    branch_data.M           = 18;

    %% included in power flow solution, not necessarily in input
    branch_data.PF          = 19;   % real power injected at "from" bus end (MW)       (not in PTI format)
    branch_data.QF          = 20;   % reactive power injected at "from" bus end (MVAr) (not in PTI format)
    branch_data.PT          = 21;   % real power injected at "to" bus end (MW)         (not in PTI format)
    branch_data.QT          = 22;   % reactive power injected at "to" bus end (MVAr)   (not in PTI format)

    %% included in opf solution, not necessarily in input
    % assume objective function has units, u
    branch_data.MU_SF       = 23;   % Kuhn-Tucker multiplier on MVA limit at "from" bus (u/MVA)
    branch_data.MU_ST       = 24;   % Kuhn-Tucker multiplier on MVA limit at "to" bus (u/MVA)
    branch_data.MU_ANGMIN   = 25;   % Kuhn-Tucker multiplier lower angle difference limit (u/degree)
    branch_data.MU_ANGMAX   = 26;   % Kuhn-Tucker multiplier upper angle difference limit (u/degree)
end