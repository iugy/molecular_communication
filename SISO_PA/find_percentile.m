clear; close all;

close all; clear;

cart = uigetdir();

folders = dir(cart);

disp("Reading data from file...");
simulations = [];
for ii = 3:length(folders)
    fprintf(".");
    cartella = folders(ii).name;
    clear('S_Name');
    load(fullfile(cart,cartella, 'simulation_parameters.mat'));
    if(~exist('S_Name', "var"))
        S_Name = ['res_dt_' num2str(dt) '_d2_' num2str(xo) '_PA_only_c_prova_' num2str(num_pr) '.mat'];
    end
    load(fullfile(cart,cartella, S_Name));

    cc = reshape(sum(c,1), size(c,2,3));
    cc = cumsum(cc(:,1))/size(c,1);

    d = norm([xo(1), yo, zo]);
    index = 0;
    for jj = 1:length(simulations)
        if(simulations(jj).distance == d)
            index = jj;
            simulations(index).d_t = [simulations(index).d_t dt];
            break;
        end        
    end
    if(index == 0)
        ax = axes(figure());
        hold(ax, "on");
        simulations = [simulations struct(...
            'distance', d, ...
            'axes', ax, ...
            'd_t', dt, ...
            'plots', [] ...
        )];
        index = length(simulations);
    end

    t = linspace(dt, T, length(cc));
    simulations(index).plots = [simulations(index).plots plot(simulations(index).axes,t,cc)];
    x90 = find(cc > 0.9*cc(end));
    x90 = x90(1);
    
    %plot(simulations(index).axes, t, ones(size(cc))*cc(x90), 'LineStyle', '--', 'Color', 'Black');
    plot(simulations(index).axes, ones(size(t))*t(x90), cc, 'LineStyle', '--', 'Color', 'Black');

    x99 = find(cc > 0.99*cc(end));
    x99 = x99(1);
    
    %plot(simulations(index).axes, t, ones(size(cc))*cc(x99), 'LineStyle', '--', 'Color', 'Red');
    plot(simulations(index).axes, ones(size(t))*t(x99), cc, 'LineStyle', '--', 'Color', 'Red');
    
   
end
fprintf("\n");

for ii = 1:length(simulations)
    lgd = legend(simulations(ii).axes, simulations(ii).plots, {num2str(simulations(ii).d_t')});
    title(simulations(ii).axes, ['Distance: ' num2str(simulations(ii).distance)]);
    title(lgd, 'dt');
    hold(simulations(ii).axes, "off");
end

