function geninfo_data=idx_geninfo()
    %% define the generator information indexing 
    geninfo_data.BUS=1; %The bus id connected with the generator
    geninfo_data.TJ=2;%the iteria of generator
    geninfo_data.RA=3;%The rotor impedance of generator
    geninfo_data.XD=4;%Direct axis synchronous reactance of generator
    geninfo_data.XDT=5;%Direct axis transient reactance of generator
    geninfo_data.XQ=6;%Quadrature axis synchronous reactance of generator
    geninfo_data.XQT=7;%Quadrature axis transient reactance of generator
    geninfo_data.TD0T=8;%Direct axis transient time constant of generator
    geninfo_data.TQ0T=9;%Transient time constant of Quadrature axis in generator
    geninfo_data.D=10;%Damping coefficient of generator
end