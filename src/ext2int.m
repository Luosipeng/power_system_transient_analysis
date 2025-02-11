%% Convert the data from external format to internal format   
function [bus,gen,branch]=ext2int(bus, gen, branch)
    index_bus=idx_bus();%Index for bus matrix
    index_branch=idx_brch();%Index for branch matrix
    index_gen=idx_gen();%Index for generator matrix
    %TODO: determine which buses, branches, gens are connected & in-service
    gen = gen(gen(:,index_gen.GEN_STATUS) ~= 0, :);
    branch = branch(branch(:,index_branch.BR_STATUS) ~= 0, :);
    % create map of external bus numbers to bus indices
    i2e = bus(:, index_bus.BUS_I);
    max_i2e = max(i2e);  % Maximum external bus number
    e2i = sparse(zeros(1, max_i2e)); % Initialize sparse mapping
    e2i(i2e) = 1:size(bus, 1); % Map external to internal bus indices
    % renumber buses consecutively
    bus(:, index_bus.BUS_I) = e2i(bus(:, index_bus.BUS_I));
    gen(:, index_gen.GEN_BUS) = e2i(gen(:, index_gen.GEN_BUS));
    branch(:, index_branch.F_BUS) = e2i(branch(:, index_branch.F_BUS));
    branch(:, index_branch.T_BUS) = e2i(branch(:, index_branch.T_BUS));
end
