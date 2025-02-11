%% This function is used to initialize the settings of power flow analysis
function Option=settings()
    %Default setting for power flow analysis
    Option.PF_ALG="NR";
    Option.PF_TOL=1e-8;
    Option.PF_MAX_IT=10;
    Option.PF_MAX_IT_FD=30;
    Option.PF_MAX_IT_GS=1000;
    Option.ENFORCE_Q_LIMS=0;
    Option.PF_DC=0;
    Option.DC=0;
    Option.NR_ALG="LU";
end