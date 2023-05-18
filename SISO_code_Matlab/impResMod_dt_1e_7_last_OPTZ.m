close all

dt = 1e-5;        % [s] sampling time (1e-7) is better, but computationally costly
D  = 7.94e-11;    % [m^2/s] diffusion constant
T  = 2;           % [s] duration of the simulation
var = 2*dt*D;     % variance
N = 1000;         % number of released particles
ro = 1e-6;        % Radius of RX sphere


%% Simulation settings

num_pr = 10;      % Number of trials

xo = 4e-6;        % center of the spherical RX along the x-axis
yo = 0;           % center of the spherical RX along the y-axis
zo = 0;           % center of the spherical RX along the z-axis

c = zeros(num_pr,N);
ww = waitbar(0, 'Progress: 0%');
for i = 1:num_pr
    waitbar((i-1)/num_pr, ww,  ['Progress: ' num2str((i-1)/num_pr*100, '%.4f') '%']);
    [cc]=exp3D_SISO(N,T,dt,var,xo,yo,zo,ro);
    c(i,:)=cc;
    S_Name = ['res_dt_1e-07_d2_' num2str(xo) '_noINT_prova_' num2str(i)];
    save(S_Name,'-v7.3');
end
close(ww);