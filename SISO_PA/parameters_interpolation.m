close all; clear;

cart = uigetdir();

folders = dir(cart);


parameters = [];

disp("Reading data from file...");
for ii = 3:length(folders)
    fprintf(".");
    cartella = folders(ii).name;
    load(fullfile(cart,cartella, 'simulation_parameters.mat'));

    load(fullfile(cart,cartella, S_Name));

    cc = reshape(sum(c,1), size(c,2,3));
    cc = cumsum(cc(:,1))/size(c,1);

    

    d = norm([xo(1), yo, zo]);
    
    modelfun = @(b,t)((N .* b(1) ./ b(2) .* erfc((b(2) - b(1)) ./ sqrt(4 .* D .* t)))');
    
    b0 = [ro/2, d-ro];
    t = dt:dt:T;
    be = nlinfit(t,cc,modelfun,b0);

    roi = be(1);
    di = be(2);
    fi = N .* roi ./ di .* erfc((di-roi) ./ sqrt(4 .* D .* t));
    
    added = false;
    for j = 1:length(parameters)
        if(d == parameters(j).distance)
            parameters(j).roi = [parameters(j).roi roi];
            parameters(j).di = [parameters(j).di di];
            parameters(j).angle = [parameters(j).angle beta];
            added = true;
        end
    end
    if(~added)
        parameters = [parameters struct(...
            'distance', d,...
            'roi', [roi],...
            'di', di,...
            'angle', beta,...
            'radius', ro)];
    end
end
fprintf("\n");

disp("Interpolating data...")
f1 = figure();
f2 = figure();
ax1 = axes(f1);
ax2 = axes(f2);
for i = 1:length(parameters)
    ang = parameters(i).angle;
    dist = parameters(i).di./parameters(i).distance;
    radi = parameters(i).roi./parameters(i).radius;
    
    [ang, I] = sort(ang);
    dist=dist(I);
    radi=radi(I);
    
    
    plot(ax1,ang,dist,'LineStyle','none','Marker','x','MarkerSize',10);
    hold(ax1,'on');
    % plot(ax1, ang./(2*pi()) + 0.5);
    % plot(ax1,ang, 0.5+0.5*sin(ang./2).^2);
    % plot(ax1,ang, 0.25+0.75*sin(ang/2).^2);
    %plot(ax1,ang, 1-2.5*parameters(i).radius/parameters(i).distance*cos(ang/2).^2);
    plot(ax1,ang, 1-1.16^(-parameters(i).distance/parameters(i).radius)*cos(ang/2).^2,'LineWidth',3);
    % for i = 1:5
    %     coeff = polyfit(ang,dist,i);
    %     yy = zeros(size(ang));
    %     for j = 1:i+1
    %         yy = yy + ang.^(j-1)*coeff(i+2-j);
    %     end
    %     plot(ang,yy);
    % end
    
    
    plot(ax2,ang,radi,'LineStyle','none','Marker','x','MarkerSize',10);
    hold(ax2,'on');
    plot(ax2,ang, sin(ang./2).^2,'LineWidth',4);
end

title(ax1,'Distance of FA receiver to approximate PA receiver')
xlabel(ax1, 'Angle beta [radians]')
ylabel(ax1,'Normalized distance')

title(ax2,'Radius of FA receiver to approximate PA receiver')
xlabel(ax2, 'Angle beta [radians]')
ylabel(ax2, 'Normalized radius')
