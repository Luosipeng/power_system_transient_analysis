function Sd = makeSdzip(baseMVA, bus)
    %Call indexing function
    index_bus=idx_bus();%Index for bus matrix
    pw = [1 0 0];%Define the type of load
    qw = pw;
    %% ZIP load model
    Sd.z = (bus(:, index_bus.PD) * pw(3)  + 1j * bus(:, index_bus.QD) * qw(3)) / baseMVA;
    Sd.i = (bus(:, index_bus.PD) * pw(2)  + 1j * bus(:, index_bus.QD) * qw(2)) / baseMVA;
    Sd.p = (bus(:, index_bus.PD) * pw(1)  + 1j * bus(:, index_bus.QD) * qw(1)) / baseMVA;
end