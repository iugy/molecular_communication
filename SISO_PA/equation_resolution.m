

t = dt:dt:T;
c = zeros(size(t));
d = norm([xo, yo, zo]);

for i = 1:length(t)
    %transparent
    %c(i) = N*ro^3*4/3*pi()/((4*pi()*D*t(i))^(3/2))*exp(-d^2/(4*D*t(i)));
    
    %FA
%     fun = @(tt) N .* ro .* (d - ro) ./ ( tt .* d .* sqrt(4.*pi().*D.*tt) ) .* exp( -(d-ro)^2 ./ (4 .* D .* tt) );
%     c(i) = integral(fun, 0, t(i));
      c(i) = N * ro * (d - ro) / ( t(i) * d * sqrt(4*pi()*D*t(i)) ) * exp( -(d-ro)^2 / (4 * D * t(i)) );
end
hold on;
plot(t, cumtrapz(t, c));
hold off;