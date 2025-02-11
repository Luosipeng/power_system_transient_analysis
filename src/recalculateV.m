function [V0,Ybus_expand]=recalculateV(mpc,delta_next,Ybus,I0,Cg)
    %Call indexing function
    index_geninfo=idx_geninfo();
    %Define generator impedance parameter
    Ra=mpc.geninfo(:,index_geninfo.RA);
    Xq=mpc.geninfo(:,index_geninfo.XQ);
    Xd_trans=mpc.geninfo(:,index_geninfo.XDT);
    %Calculate the generator impedance
    Gx=(Ra-(Xd_trans-Xq).*sin(delta_next).*cos(delta_next))./(Ra.^2+Xd_trans.*Xq);
    Gy=(Ra+(Xd_trans-Xq).*sin(delta_next).*cos(delta_next))./(Ra.^2+Xd_trans.*Xq);
    Bx=(Xd_trans.*cos(delta_next).^2+Xq.*sin(delta_next).^2)./(Ra.^2+Xd_trans.*Xq);
    By=(-Xd_trans.*sin(delta_next).^2-Xq.*cos(delta_next).^2)./(Ra.^2+Xd_trans.*Xq);

    %% Expand Ybus
    G=real(Ybus);
    B=imag(Ybus);

    %% Some new matrix operations
    n = size(Ybus, 1);
    % Create jacindexM
    iM = 1:2:(2*n - 1); 
    jM = 1:n;  
    jacindexM = sparse(iM, jM, ones(size(iM)), 2*n, n);
    % Create jacindexM_inverse
    iM_inv = 1:n;  
    jM_inv = 1:2:(2*n - 1);  
    jacindexM_inverse = sparse(iM_inv, jM_inv, ones(size(iM_inv)), n, 2*n); 
    % Create jacindexN
    iN = 2:2:(2*n);  
    jN = 1:n;  
    jacindexN = sparse(iN, jN, ones(size(iN)), 2*n, n); 
    
    % Create jacindexN_inverse
    iN_inv = 1:n;  
    jN_inv = 2:2:(2*n);  
    jacindexN_inverse = sparse(iN_inv, jN_inv, ones(size(iN_inv)), n, 2*n);  

    Gx_gen=zeros(size(mpc.bus,1),1);
    Gy_gen=zeros(size(mpc.bus,1),1);
    Bx_gen=zeros(size(mpc.bus,1),1);
    By_gen=zeros(size(mpc.bus,1),1);
    Gx_gen(Cg)=Gx;
    Gy_gen(Cg)=Gy;
    Bx_gen(Cg)=Bx;
    By_gen(Cg)=By;
    Gx_gen=diag(Gx_gen);
    Gy_gen=diag(Gy_gen);
    Bx_gen=diag(Bx_gen);
    By_gen=diag(By_gen);
    Ybus_expand11=jacindexM*(Gx_gen+G)*jacindexM_inverse;
    Ybus_expand12=jacindexM*(Bx_gen-B)*jacindexN_inverse;
    Ybus_expand21=jacindexN*(By_gen+B)*jacindexM_inverse;
    Ybus_expand22=jacindexN*(Gy_gen+G)*jacindexN_inverse;
    Ybus_expand=Ybus_expand11+Ybus_expand12+Ybus_expand21+Ybus_expand22;

    %Ybus_expand(2*Cg-1,2*Cg-1)=Ybus_expand(2*Cg-1,2*Cg-1)+Gx;
    %Ybus_expand(2*Cg-1,2*Cg)=Ybus_expand(2*Cg-1,2*Cg)+Bx;
    %Ybus_expand(2*Cg,2*Cg-1)=Ybus_expand(2*Cg,2*Cg-1)+By;
    %Ybus_expand(2*Cg,2*Cg)=Ybus_expand(2*Cg,2*Cg)+Gy;
    
    Ix=real(I0);
    Iy=imag(I0);

    I = zeros(2 * length(Ix), 1);
    I(1:2:end) = Ix;  
    I(2:2:end) = Iy;  
    
    V=Ybus_expand^-1 *I;
    Vx=V(1:2:end);
    Vy=V(2:2:end);
    V0=Vx+1i*Vy;
end