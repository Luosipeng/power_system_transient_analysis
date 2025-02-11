function mpc = case_3bus_system
%CASE_4BUS_SYSTEM    Power flow data for 9 bus, 3 generator case.
%   Modified from MATPOWER
%   BaseKV and BaseMVA is not correct in this example proviede in the
%   textbook.But it can not affect the accuracy of power flow result
%   because the data in textbook is all norminal data.
%% IEEE Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	2	0	0	0	0	1	1.0 	0       115	1	1.1	0.9;
	2	1	0	0	0	0	1	1.0 	0       115	1	1.1	0.9;
	3	3	0	0	0	0	1	1.0     0       115	1	1.1	0.9;

];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	60     40     300	-300	1.0 	100	1	250	10	0	0	0	0	0	0	0	0	0	0	0;
	3	0.0    0.0    300	-300	1.0	100	1	1e3	1e-3	0	0	0	0	0	0	0	0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	1	2	0	0.0576	0	250	150	150	0	0	1	-360	360;
	2	3	0.010	0.085	0.176	300	300	300	0	0	1	-360	360;
	2	3	0.010	0.085	0.176	300	300	300	0	0	1	-360	360;
];
%% other generator info
%   bus     Tj     Ra      Xd     Xd'    Xq    Xq'    Td0'    Tq0'    D
mpc.geninfo=[
    1       12.8   0.0 0.8958   0.1198  0.8645  0.1969  6.00    0.535   0.0;    
    3       10000  0.0  0.001   0.1198   0.001   0.001   1000    1000    0.0;
    
];