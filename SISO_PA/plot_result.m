clear; close all;


cartella = uigetdir('saves\');

load(fullfile(cartella, 'simulation_parameters'));
if(~exist('S_Name', "var"))
    S_Name = ['res_dt_' num2str(dt) '_d2_' num2str(xo) '_PA_only_c_prova_' num2str(num_pr) '.mat'];
end
load(fullfile(cartella, S_Name));

cc= reshape(sum(c,1), size(c,2,3));
cc = cumsum(cc(:,1))/size(c,1);

t = linspace(dt,T,length(cc));

plot(t, cc, 'Linewidth', 4);

d = norm([xo(1), yo, zo]);
title(['d = ' num2str(d) ', ro = ' num2str(rad2deg(beta)) '°']);
xlabel('Time [s]');
ylabel('Absorbed particles (cumulative)');
hold on;


%% FA (single line)

% f = N .* ro ./ d .* erfc((d-ro) ./ sqrt(4 .* D .* t));
% plot(t, f);

%% FA (multiple lines)

% roi = (0.12*ro:0.002*ro:0.14*ro)';
% di = d+ro*( (1-cos(2*beta))/((1-cos(beta))*4) - 1);
% di = d - 2*ro;
% fi = N .* roi ./ di .* erfc((di-roi) ./ sqrt(4 .* D .* t));
% plot(t, fi);

%% FA (nonlinear regression)

modelfun = @(b,t)((N .* b(1) ./ b(2) .* erfc((b(2) - b(1)) ./ sqrt(4 .* D .* t)))');

t = linspace(dt,T,length(cc));
b0 = [ro/2, d-ro];

be = nlinfit(t,cc,modelfun,b0);

roi = be(1);
di = be(2);
fi = N .* roi ./ di .* erfc((di-roi) ./ sqrt(4 .* D .* t));
plot(t, fi, 'Linewidth', 4,'LineStyle', '--');

%% FA (worked out approximation) 

ro2 = ro.*sin(beta./2).^2;
d2 = (1-1.16^(-d/ro)*cos(beta/2).^2)*d;
f2 = N .* ro2 ./ d2 .* erfc((d2-ro2) ./ sqrt(4 .* D .* t));
plot(t, f2, 'Linewidth', 4,'LineStyle', '--');

%% PA

% equations [17] and [18] from 
% "Molecular Signal Modeling of a Partially Counting Absorbing Spherical Receiver"

% U = d.^2 .* (D .* t .* erfc((d-ro)./sqrt(4.*D.*t)) + sqrt(D.*t).*(d-ro).*expint(-(d-ro).^2./(4.*D.*t))) ./ ...
%     (D .* ro .* t .* (d-ro)) - ...
%     d.^2 .* (D .* t .* erfc((d+ro)./sqrt(4.*D.*t)) + sqrt(D.*t).*(d+ro).*expint(-(d+ro).^2./(4.*D.*t))) ./ ...
%     (D .* ro .* t .* (d+ro));
% 
% Fat = N .*(erfc((d-ro)./sqrt(4.*D.*t)).*( D.*t.* erfc(sqrt(d.^2-2.*d.*ro+ro.^2)./sqrt(4.*D.*t)) + ...
%     1./(2.*sqrt(pi())) .* sqrt(D.*t) .* sqrt(d.^2-2.*d.*ro+ro.^2) .* expint(-(d.^2-2.*d.*ro+ro.^2)./(4.*D.*t)) ) ./ ...
%     ( U .* D .* t .* sqrt((d.^2 - 2.*d.*ro + ro.^2)./d.^2))) - ...
%     erfc((d-ro)./sqrt(4.*D.*t)).*( D.*t.* erfc(sqrt(d.^2-2.*d.*ro.*cos(beta)+ro.^2)./sqrt(4.*D.*t)) + ...
%     1./(2.*sqrt(pi())) .* sqrt(D.*t) .* sqrt(d.^2-2.*d.*ro.*cos(beta)+ro.^2) .* expint(-(d.^2-2.*d.*ro.*cos(beta)+ro.^2)./(4.*D.*t)) ) ./ ...
%     ( U .* D .* t .* sqrt((d.^2 - 2.*d.*ro.*cos(beta) + ro.^2)./d.^2));
% 
% plot(t, Fat, '--');

% y=sqrt(4.*D.*t);
% xbeta = sqrt(d.^2 - 2.*d.*ro.*cos(beta) + ro.^2);
% omega = 1./(d-ro) .* erfc((d-ro)./y) - 1./xbeta .* erfc(xbeta ./ y) + ...
%     1./sqrt(2.*pi().*D.*t) .* ( expint(-(d-ro).^2./y.^2) - expint(-xbeta.^2./y.^2) );
% U = 1./(d-ro) .* erfc((d-ro)./y) - 1./(d+ro).*erfc( (d+ro)./y ) + ...
%     1./sqrt(D.*t).*( expint(-(d-ro).^2./y.^2) - expint(-(d+ro).^2./y.^2) );
% Fbt =N .* ro ./ d .* erfc((d-ro)./y) .* omega ./ U;
% 
% plot(t, Fbt, '--');
%% Relation plots



% figure();
% hold on;
% % plot(t, (cumsum(cc(:,1))/10)./xx');
% plot(t, (cumsum(cc(:,1))/10)./f');
% hold off;