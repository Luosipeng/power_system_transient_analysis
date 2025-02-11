function bus_data = idx_bus()
    %% define bus types
    bus_data.PQ    = 1; % PQ bus type
    bus_data.PV    = 2; % PV bus type
    bus_data.REF   = 3; % Reference bus type
    bus_data.Pdc   = 4; % Direct Current Power Bus (optional)
    bus_data.Vdc   = 5; % Voltage Controlled DC bus (optional)
    bus_data.NONE  = 6; % Undefined or invalid type

    %% define the indices
    bus_data.BUS_I     = 1;    % bus number (1 to 29997)
    bus_data.BUS_TYPE  = 2;    % bus type (1 - PQ bus, 2 - PV bus, 3 - reference bus, 4 - isolated bus)
    bus_data.PD        = 3;    % Pd, real power demand (MW)
    bus_data.QD        = 4;    % Qd, reactive power demand (MVAr)
    bus_data.GS        = 5;    % Gs, shunt conductance (MW at V = 1.0 p.u.)
    bus_data.BS        = 6;    % Bs, shunt susceptance (MVAr at V = 1.0 p.u.)
    bus_data.BUS_AREA  = 7;    % area number, 1-100
    bus_data.VM        = 8;    % Vm, voltage magnitude (p.u.)
    bus_data.VA        = 9;    % Va, voltage angle (degrees)
    bus_data.BASE_KV   = 10;   % baseKV, base voltage (kV)
    bus_data.ZONE      = 11;   % zone, loss zone (1-999)
    bus_data.VMAX      = 12;   % maxVm, maximum voltage magnitude (p.u.)      (not in PTI format)
    bus_data.VMIN      = 13;   % minVm, minimum voltage magnitude (p.u.)      (not in PTI format)

    %% included in opf solution, not necessarily in input
    % assume objective function has units, u
    bus_data.LAM_P     = 14;   % Lagrange multiplier on real power mismatch (u/MW)
    bus_data.LAM_Q     = 15;   % Lagrange multiplier on reactive power mismatch (u/MVAr)
    bus_data.MU_VMAX   = 16;   % Kuhn-Tucker multiplier on upper voltage limit (u/p.u.)
    bus_data.MU_VMIN   = 17;   % Kuhn-Tucker multiplier on lower voltage limit (u/p.u.)
end
