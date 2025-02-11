function [V, converged, i]=newtonpf(bus,gen,branch,Ybus,ref,pv,pq,Cg_matrix,baseMVA,Tol0,maxiter0,alg)
 %% Recall index function
    index_bus=idx_bus();%Index for bus matrix
    %index_branch=idx_brch();%Index for branch matrix
    %index_gen=idx_gen();%Index for generator matrix
    
    Vm=bus(:,index_bus.VM);
    Va=bus(:,index_bus.VA);
    V=Vm .* exp(1i * Va);
    Tol=Tol0;
    Maxiter=maxiter0;
   
    %% Initialize
    converged=false;
    i=0;
    %% Set up indexing for updating variables
    npv = length(pv);
    npq = length(pq);
    j1 = 1; j2 = npv; %j1:j2 - V angle of pv buses
    j3 = j2 + 1; j4 = j2 + npq; %j3:j4 - V angle of pq buses
    j5 = j4 + 1; j6 = j4 + npq; %j5:j6 - V mag of pq buses
    %% Evaluate F(x0)
    mis = V .* conj(Ybus * V) - makeSbus(bus,gen,baseMVA,Vm);
    F = [real(mis([pv; pq])); imag(mis(pq))];
    %% Check tolerance
    normF = norm(F, Inf);
    if normF < Tol
        converged = true;
    end
    %% Do Newton iterations
    while (~converged && i < Maxiter)
       % Update iteration counter
        i=i+1;
        % Evaluate Jacobian
        [dSbus_dVa, dSbus_dVm] = dSbus_dV(Ybus, V);
        j11 = real(dSbus_dVa([pv; pq], [pv; pq]));
        j12 = real(dSbus_dVm([pv; pq], pq));
        j21 = imag(dSbus_dVa(pq, [pv; pq]));
        j22 = imag(dSbus_dVm(pq, pq));
        J = [j11 j12; j21 j22];
        % Compute update step
        [dx,info]= linearsolve(J, -F, alg);
        % Update voltage
        if npv > 0
            Va(pv)=Va(pv)+dx(j1:j2);
        end
        if npq > 0
            Va(pq)=Va(pq)+dx(j3:j4);
            Vm(pq)=Vm(pq)+dx(j5:j6);
        end
        V = Vm .* exp(1i * Va);
        Vm = abs(V); % Update Vm and Va again in case we wrapped around with a negative Vm
        Va = angle(V);
        % Evaluate F(x)
        mis = V .* conj(Ybus * V) - makeSbus(bus,gen,baseMVA,Vm);
        F = [real(mis([pv; pq])); imag(mis(pq))];

        % Check for convergence
        normF = norm(F, Inf);
        if normF < Tol
            converged = true;
        end 
    end
end