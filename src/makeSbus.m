function Sbus=makeSbus(bus,gen,baseMVA,Vm)
    %Call indexing function
    index_bus=idx_bus();%Index for bus matrix
    index_branch=idx_brch();%Index for branch matrix
    index_gen=idx_gen();%Index for generator matrix   
    nb = size(bus, 1);
    %% get load parameters
    Sd = makeSdzip(baseMVA, bus);
    if nargout == 2
        Sbus = [];
        if isempty(Vm)
            dSbus_dVm = sparse(nb, nb);
        else
            dSbus_dVm = -(spdiags(Sd.i + 2 * Vm .* Sd.z, 0, nb, nb));
        end
    else
    %% compute per-bus generation in p.u.
    on = find(gen(:, index_gen.GEN_STATUS) > 0);      %% which generators are on?
    gbus = gen(on, index_gen.GEN_BUS);                %% what buses are they at?
    ngon = size(on, 1);
    Cg = sparse(gbus, (1:ngon)', 1, nb, ngon);  %% connection matrix
    Sbusg = Cg * (gen(on, index_gen.PG) + 1j * gen(on, index_gen.QG)) / baseMVA;
    %% compute per-bus loads in p.u.
    if isempty(Vm)
        Vm = ones(nb, 1);
    end
    Sbusd = Sd.p + Sd.i .* Vm + Sd.z .* Vm.^2;
    %% form net complex bus power injection vector
    %% (power injected by generators + power injected by loads)
    Sbus = Sbusg - Sbusd;
end