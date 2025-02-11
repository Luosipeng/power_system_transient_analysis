function [Pd, Qd]=total_load(bus)
    %Call indexing function
    index_bus=idx_bus();%Index for bus matrix
    index_gen=idx_gen();%Index for generator matrix  
    
    nb=size(bus, 1); % number of buses
    % default options
    want_Q=1;
    % fixed load at each bus, & initialize dispatchable
    Sd = makeSdzip(1, bus);
    Vm = bus(:, index_bus.VM);
    Sbusd = Sd.p + Sd.i .* Vm + Sd.z .* Vm.^2;
    Pdf = real(Sbusd); % real power
    if want_Q==1
        Qdf = imag(Sbusd); % reactive power
    end
    %dispatchable load at each bus
    Pdd = zeros(nb, 1);
    if want_Q==1
        Qdd=zeros(nb, 1);
    end
    %compute load sums
    Pd = (Pdf + Pdd) .* (bus(:, index_bus.BUS_TYPE)~=index_bus.NONE-2);
    if want_Q==1
        Qd = (Qdf + Qdd) .* (bus(:, index_bus.BUS_TYPE)~=index_bus.NONE-2);
    end
end