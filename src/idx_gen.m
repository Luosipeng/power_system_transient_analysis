function gen_data =idx_gen()
   %% define the indices
    gen_data.GEN_BUS     = 1;    % bus number
    gen_data.PG          = 2;    % Pg, real power output (MW)
    gen_data.QG          = 3;    % Qg, reactive power output (MVAr)
    gen_data.QMAX        = 4;    % Qmax, maximum reactive power output at Pmin (MVAr)
    gen_data.QMIN        = 5;    % Qmin, minimum reactive power output at Pmin (MVAr)
    gen_data.VG          = 6;    % Vg, voltage magnitude setpoint (p.u.)
    gen_data.MBASE       = 7;    % mBase, total MVA base of this machine, defaults to baseMVA
    gen_data.GEN_STATUS  = 8;    % status, 1 - machine in service, 0 - machine out of service
    gen_data.PMAX        = 9;    % Pmax, maximum real power output (MW)
    gen_data.PMIN        = 10;   % Pmin, minimum real power output (MW)
    gen_data.PC1         = 11;   % Pc1, lower real power output of PQ capability curve (MW)
    gen_data.PC2         = 12;   % Pc2, upper real power output of PQ capability curve (MW)
    gen_data.QC1MIN      = 13;   % Qc1min, minimum reactive power output at Pc1 (MVAr)
    gen_data.QC1MAX      = 14;   % Qc1max, maximum reactive power output at Pc1 (MVAr)
    gen_data.QC2MIN      = 15;   % Qc2min, minimum reactive power output at Pc2 (MVAr)
    gen_data.QC2MAX      = 16;   % Qc2max, maximum reactive power output at Pc2 (MVAr)
    gen_data.RAMP_AGC    = 17;   % ramp rate for load following/AGC (MW/min)
    gen_data.RAMP_10     = 18;   % ramp rate for 10 minute reserves (MW)
    gen_data.RAMP_30     = 19;   % ramp rate for 30 minute reserves (MW)
    gen_data.RAMP_Q      = 20;   % ramp rate for reactive power (2 sec timescale) (MVAr/min)
    gen_data.APF         = 21;   % area participation factor

   %% included in opf solution, not necessarily in input
    % assume objective function has units, u
    gen_data.MU_PMAX     = 22;   % Kuhn-Tucker multiplier on upper Pg limit (u/MW)
    gen_data.MU_PMIN     = 23;   % Kuhn-Tucker multiplier on lower Pg limit (u/MW)
    gen_data.MU_QMAX     = 24;   % Kuhn-Tucker multiplier on upper Qg limit (u/MVAr)
    gen_data.MU_QMIN     = 25;   % Kuhn-Tucker multiplier on lower Qg limit (u/MVAr)

   %% Note: When a generator's PQ capability curve is not simply a box and the
    % upper Qg limit is binding, the multiplier on this constraint is split into
    % it's P and Q components and combined with the appropriate MU_Pxxx and
    % MU_Qxxx values. Likewise for the lower Q limits.
end