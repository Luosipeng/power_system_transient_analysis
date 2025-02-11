%% This file is designed to calculate the initial value in transient analysis
%%
function [delta0,omega0,Eq_trans,Y0,Pm0,Pe0,V0,I0]=calculate_initial_value(mpc,Cg,baseMVA)
    %Call indexing function
    
    %Define generator output
    P0=mpc.gen(:,2)./baseMVA;
    Q0=mpc.gen(:,3)./baseMVA;
    %Define load 
    P_load0=mpc.bus(:,3)/baseMVA;
    Q_load0=mpc.bus(:,4)/baseMVA;
    %Define generator impedance parameter
    Ra=mpc.geninfo(:,3);
    Xq=mpc.geninfo(:,6);
    Xd_trans=mpc.geninfo(:,5);
    %Calculate voltage of all buses in the power system
    V0=mpc.bus(:,8).*exp(1i * mpc.bus(:,9)/180*pi);
    %V = Vm .* exp(1j * Va)
    S0=P0+1i*Q0;%generator output power
    I0=conj(S0./V0(Cg,:));%generator input circuit
    EQ0=V0(Cg,:)+(Ra+1i*Xq).*I0;%generator virtural voltage
    delta0=angle(EQ0);%generator angle
    omega0=ones(size(mpc.gen,1),1);%initial angle speed
    %Park trans
    Vx=real(V0(Cg,:));
    Vy=imag(V0(Cg,:));
    Ix=real(I0);
    Iy=imag(I0);
    Vd=sin(delta0).*Vx-cos(delta0).*Vy;
    Vq=cos(delta0).*Vx+sin(delta0).*Vy;
    Id=sin(delta0).*Ix-cos(delta0).*Iy;
    Iq=cos(delta0).*Ix+sin(delta0).*Iy;
    %Obtain the transient voltage
    Eq_trans=Vq+Ra.*Iq+Xd_trans.*Id;
    %E_trans=V0(Cg,:)+(Ra+1i*Xd_trans).*(P0-1i*Q0)./V0(Cg,:);%Transient voltage of generators
    %Eq_trans=E_trans;
    Pm0=P0+abs(I0).^2 .*Ra;%machine power of generators
    Pe0=Pm0;%electric power of generators
    S_load=P_load0+1i*Q_load0;
    Y0=conj(S_load)./(mpc.bus(:,8).^2);
    % delta0=delta0*180/pi;
end