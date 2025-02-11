function [Ybus,Yf,Yt]=makeYbus(baseMVA,bus,branch)
    %% define named indices into bus, branch matrices
    index_bus=idx_bus();%Index for bus matrix
    index_branch=idx_brch();%Index for branch matrix
    %% constants
    nb = size(bus, 1);% number of buses
    nl = size(branch, 1);% number of lines
    %% check that bus numbers are equal to indices to bus (one set of bus numbers)
    if any(bus(:, index_bus.BUS_I) ~= (1:nb).')
        error("makeYbus: buses must be numbered consecutively in bus matrix; use ext2int() to convert to internal ordering")
    end
    %% for each branch, compute the elements of the branch admittance matrix where
    stat = branch(:, index_branch.BR_STATUS);% ones at in-service branches
    Ys = stat ./ (branch(:, index_branch.BR_R) + 1i * branch(:, index_branch.BR_X));% series admittance
    Bc = stat .* branch(:, index_branch.BR_B);% line charging susceptance
    tap = ones(nl,1);% default tap ratio = 1
    i = find(branch(:, index_branch.TAP) ~= 0);% indices of non-zero tap ratios
    tap(i) = branch(i, index_branch.TAP);% assign non-zero tap ratios
    tap = tap .* exp(1i*pi/180 * branch(:, index_branch.SHIFT));% add phase shifters
    Ytt = Ys + 1i*Bc/2;
    Yff = Ytt ./ (tap .* conj(tap));
    Yft = - Ys ./ conj(tap);
    Ytf = - Ys ./ tap;
    %% compute shunt admittance
    Ysh = (bus(:, index_bus.GS) + 1i * bus(:, index_bus.BS)) / baseMVA;% vector of shunt admittances
    %% bus indices
    f = branch(:, index_branch.F_BUS);                           % list of "from" buses
    t = branch(:, index_branch.T_BUS);                           % list of "to" buses
    %% build connection matrices
    Cf = sparse(1:nl, f, ones(nl, 1), nl, nb);      % connection matrix for line & from buses
    Ct = sparse(1:nl, t, ones(nl, 1), nl, nb);      % connection matrix for line & to buses
    %% build Yf and Yt such that Yf * V is the vector of complex branch currents injected
    % at each branch's "from" bus, and Yt is the same for the "to" bus end
    Yf = sparse(1:nl, 1:nl, Yff, nl, nl) * Cf + sparse(1:nl, 1:nl, Yft, nl, nl) * Ct;
    Yt = sparse(1:nl, 1:nl, Ytf, nl, nl) * Cf + sparse(1:nl, 1:nl, Ytt, nl, nl) * Ct;
    %% build Ybus
    Ybus = Cf' * Yf + Ct' * Yt + sparse(1:nb, 1:nb, Ysh, nb, nb);    
end