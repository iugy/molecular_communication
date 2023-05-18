close all; clear;

load('last_simulation_data.mat');

load(S_Name);

cc = sum(c,1)/num_pr;

cc = cumsum(cc, 2);

cc = reshape(cc, size(cc, 2), size(cc, 3));

t=dt:dt:T;

plot(t, cc)


d1  = sqrt(dims(1).xo^2 + dims(1).yo^2 + dims(1).zo^2);
d2  = sqrt(dims(2).xo^2 + dims(2).yo^2 + dims(2).zo^2);
d12 = sqrt((dims(1).xo-dims(2).xo)^2 + (dims(1).yo-dims(2).yo)^2 + (dims(1).zo-dims(2).zo)^2);

Nt = N*dims(1).ro * ...
    (d12*d2-dims(1).ro*d1) / (d1*d2*d12) * ...
    (d12*d12) / (d12*d12-dims(1).ro^2);

hold on;
plot([0 T],[Nt Nt]);
hold off;