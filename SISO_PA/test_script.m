clear; close all;

dt = 1e-6;        % [s] sampling time (1e-7) is better, but computationally costly
D  = 7.94e-11;    % [m^2/s] diffusion constant
T  = 2;           % [s] duration of the simulation
var = 2*dt*D;     % variance
N = 1000;         % number of released particles
ro = 1e-6;        % Radius of RX sphere
beta = pi()/4;

xo = 4e-6;        % center of the spherical RX along the x-axis
yo = 0;           % center of the spherical RX along the y-axis
zo = 0;           % center of the spherical RX along the y-axis

d = norm([xo(1), yo, zo]);


T = 0.5;
di = 0.5*d:0.01*d:d;
roi = 0.1*ro:0.01*ro:ro; 
t = 0:1e-2:T;

fi = N .* roi ./ di' .* erfc((di'-roi) ./ sqrt(4 .* D .* T));

surf(roi,di,fi);