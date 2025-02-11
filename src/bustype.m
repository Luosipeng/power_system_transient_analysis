function [ref,pq,pv] =bustype(gen,bus)
    %% Recall the index function 
    index_bus=idx_bus();%Index for bus matrix
    index_gen=idx_gen();%Index for generator matrix
    %% Judge the bustypes
    gen_ref=find(bus(gen(:,index_gen.GEN_BUS),index_bus.BUS_TYPE)==3);%find the ref buses(bus type should be 3 and connected with a generator)
    gen_pv=find(bus(gen(:,index_gen.GEN_BUS),index_bus.BUS_TYPE)==2);%find the pv buses(bus type should be 2 and connected with a generator
    ref=gen(gen_ref,index_gen.GEN_BUS);
    pv=gen(gen_pv,index_gen.GEN_BUS);
    % Initialize PQ buses as all bus IDs
    pq = bus(:, index_bus.BUS_I);
    % Remove REF and PV buses from PQ buses
    index = unique([ref; pv]); % Combine REF and PV buses, ensuring no duplicates
    pq(ismember(pq, index)) = []; % Remove REF and PV buses
end