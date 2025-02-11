function mpc = case_9bus_system
%CASE_1BUS_SYSTEM    Power flow data for 9 bus, 3 generator case.
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
	1	3	0	0	0	0	1	1.04	0       115	1	1.1	0.9;
	2	2	0	0	0	0	1	1.025 	0	115	1	1.1	0.9;
	3	2	0	0	0	0	1	1.025 	0	115	1	1.1	0.9;
	4	1	0	0	0	0	1	1.0 	0	115	1	1.1	0.9;
	5	1	125	50	0	0	1	1.0 	0	115	1	1.1	0.9;
	6	1	90	30	0	0	1	1.0 	0	115	1	1.1	0.9;
	7	1	0	0	0	0	1	1.0 	0	115	1	1.1	0.9;
	8	1	100	35	0	0	1	1.0 	0	115	1	1.1	0.9;
	9	1	0	0	0	0	1	1.0 	0	115	1	1.1	0.9;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	0   	0	300	-300	1.04	100	1	250	10	0	0	0	0	0	0	0	0	0	0	0;
	2	163     0	300	-300	1.025	100	1	300	10	0	0	0	0	0	0	0	0	0	0	0;
	3	85      0	300	-300	1.025	100	1	270	10	0	0	0	0	0	0	0	0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	1	4	0	    0.0576	0	    100	100	100	0	0	1	-360	360;
	2	7	0	    0.0625	0	    100	100	100	0	0	1	-360	360;
	3	9	0	    0.0586	0	    100	100	100	0	0	1	-360	360;
	4	5	0.010	0.085	0.176	100	100	100	0	0	1	-360	360;
	4	6	0.017	0.092	0.158	100	100	100	0	0	1	-360	360;
	5	7	0.032	0.161	0.306	100	100	100	0	0	1	-360	360;
	6	9	0.039	0.170	0.358	100	100	100	0	0	1	-360	360;
	7	8	0.0085	0.072	0.149	100	100	100	0	0	1	-360	360;
	8	9	0.0119	0.1008	0.209	100	100	100	0	0	1	-360	360;
];
%% generator information
%   bus     Tj     Ra      Xd     Xd'    Xq    Xq'    Td0'    Tq0'    D
mpc.geninfo=[
    1   47.28   0.0 0.146   0.0608  0.0608  0.0969  8.96    0.535   0.0;    
    2   12.80   0.0 0.8958  0.1198  0.1198  0.1969  6.00    0.535   0.0;
    3   6.02    0.0 1.3125  0.1813  0.1813  0.2500  5.89    0.6     0.0;
];
