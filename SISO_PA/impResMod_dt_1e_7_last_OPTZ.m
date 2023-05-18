close all; clear;

dt_ = 10.^(-5:-0.5:-6);        % [s] sampling time (1e-7) is better, but computationally costly
D  = 7.94e-11;    % [m^2/s] diffusion constant
T  = 60;           % [s] duration of the simulation

N = 1000;         % number of released particles
ro = 1e-6;        % Radius of RX sphere
beta_ = pi()/3;
num_pr = 10;      % Number of trials
xo_ = [1.00001e-6, 5e-5];        % center of the spherical RX along the x-axis
yo = 0;           % center of the spherical RX along the y-axis
zo = 0;           % center of the spherical RX along the z-axis
%% Simulation settings
total_simulations = length(dt_)*length(beta_)*length(xo_)*num_pr;
count = 0;
t_start = tic();
t_2 = 0;
iterations = [length(dt_), length(beta_), length(xo_)];


for beta = beta_
for xo = xo_
for dt = dt_

    var = 2*dt*D;     % variance
    count = 0;
    final_dire = fullfile(cd, 'saves', ...
        strcat(string(datetime('now', 'Format', 'yyyy-MM-dd_HH-mm-ss')), ...
            '_beta_', num2str(360*beta/(2*pi())), ...
            '_d_', num2str(xo), ...
            '_dt_', num2str(dt)));
    dire = strcat(final_dire, '_INCOMPLETE');
    mkdir(dire);
    name = fullfile(dire, 'simulation_parameters');
    S_Name = ['res_dt_' num2str(dt) '_d2_' num2str(xo(1)) '_PA_only_c_prova_' num2str(num_pr) '.mat'];
    save(name, '-v7.3');
    
    c = zeros(num_pr,round(T/dt));
    ww = waitbar(0, 'Please wait ...');
    for i = 1:num_pr
        waitbar(((i-1))/(num_pr*length(xo)), ww,  ['Progress: ' num2str(((i-1))/(num_pr*length(xo))*100) '%']);
        [ETAh, ETAm, ETAs] = hms(duration(seconds(t_2/count*(total_simulations-count))));
        waitbar(count/total_simulations, ww,  ['ETA: ' num2str(ETAh) 'h ' num2str(ETAm) 'm ' num2str(ETAs) 's']);
        [cc]=exp3D_SISO_PA(N,T,dt,var,xo,yo,zo,ro,beta);
        c(i,:)=cc;
    
        S_Name = ['res_dt_' num2str(dt) '_d2_' num2str(xo(1)) '_PA_only_c_prova_' num2str(num_pr) '.mat'];
    
        save(fullfile(dire,S_Name), 'c', '-v7.3');
        t_2 = toc();
        count = count+1;
        send(DQ, i);
    end
    movefile(dire,final_dire);
end
end
end
close(ww);
