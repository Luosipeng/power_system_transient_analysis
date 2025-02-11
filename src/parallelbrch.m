%% This function is designed to operate on branch matrix.
%To combine two parallel branched into one branches
%The input :branch matrix
%The output brc matrix(have been operated)
function [brc,duplicate_pairs] = parallelbrch(branch)
    index_branch = idx_brch(); % Index for branch matrix
    % Extract FBUS and TBUS from branch
    fbus_tbus = branch(:, index_branch.F_BUS:index_branch.T_BUS);
    %% Calculate admittance and prepare line charging susceptance
    z = branch(:, index_branch.BR_R) + 1i * branch(:, index_branch.BR_X); % Z = R + jX
    y = 1 ./ z; % Y = 1 / Z (admittance)
    b = branch(:, index_branch.BR_B); % Line charging susceptance
    %% Create a unique key for each FBUS-TBUS pair
    [unique_pairs, ~, group_idx] = unique(fbus_tbus, 'rows');
    %% Find the repeated FBUS-TBUS pairs
    duplicate_pairs_idx = find(histc(group_idx, unique(group_idx)) > 1); % Indices of repeated pairs
    duplicate_pairs = unique_pairs(duplicate_pairs_idx, :); % Repeated FBUS-TBUS pairs
    %% Initialize arrays to store the results
    num_pairs = size(unique_pairs, 1);
    combined_y = accumarray(group_idx, y); % Sum of admittance for each pair
    combined_b = accumarray(group_idx, b); % Sum of susceptance for each pair
    
    %% Convert combined admittance back to impedance
    combined_z = 1 ./ combined_y;
    combined_r = real(combined_z); % Resistance
    combined_x = imag(combined_z); % Reactance
    
    %% Construct the new branch matrix
    new_branch = [unique_pairs, combined_r, combined_x, combined_b, zeros(num_pairs, 5), ...
                  ones(num_pairs, 1), -360.*ones(num_pairs, 1), 360.*ones(num_pairs, 1)]; % Fill other columns with zeros
    
    %% Replace the branch data in the case
    brc = new_branch;
    
    %% Display or return the repeated pairs if necessary
    if ~isempty(duplicate_pairs)
        disp('Found the following duplicate FBUS-TBUS pairs:');
        disp(duplicate_pairs);
    end
end
