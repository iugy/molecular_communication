close all; clear

dt = 1e-5;        % [s] sampling time (1e-7) is better, but computationally costly
D  = 7.94e-11;    % [m^2/s] diffusion constant
T  = 60;           % [s] duration of the simulation
var = 2*dt*D;     % variance
N = 1000;         % number of released particles
ro = 1e-6;        % Radius of RX sphere


%% Simulation settings

num_pr = 10;      % Number of trials

%reciver 1
dims(1) = struct( ...
'xo' , 4e-6, ...        % center of the spherical RX along the x-axis
'yo' , 0, ...           % center of the spherical RX along the y-axis
'zo' , 0, ...           % center of the spherical RX along the z-axis
'ro' , ro);

%reciver 2
dims(2) = struct( ...
'xo' , -4e-6, ...        % center of the spherical RX along the x-axis
'yo' , 0, ...           % center of the spherical RX along the y-axis
'zo' , 0, ...           % center of the spherical RX along the z-axis
'ro' , ro); 

S_Name = ['res_dt_' num2str(dt) '_d2_noINT_prova_' num2str(num_pr)];
save('last_simulation_data');

c = zeros(num_pr,round(T/dt),length(dims));
ww = waitbar(0, "0%");
for i = 1:num_pr
    waitbar((i-1)/num_pr, ww,  [num2str((i-1)/num_pr*100, '%.4f') '%']);
    [cc]=exp3D_SIMO(N,T,dt,var,dims);
    c(i,:,:)=cc;
    S_Name = ['res_dt_' num2str(dt) '_d2_noINT_prova_' num2str(i)];
    save(S_Name, 'c','-v7.3');
end
close(ww);