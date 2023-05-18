function [c]=exp3D_SISO(N,T,dt,var,xo,yo,zo,ro)
x = zeros(1,N);
y = zeros(1,N);
z = zeros(1,N);
c = zeros(1,N);
iii = 1;
SQRT_VAR = sqrt(var);

for icf =2:round(T/dt)
    
    Dx = SQRT_VAR*randn(size(x));
    Dy = SQRT_VAR*randn(size(y));
    Dz = SQRT_VAR*randn(size(z));
    x = x + Dx;
    y = y + Dy;
    z = z + Dz;
    
    ind = find( (x-xo(1)).^2+(y-yo(1)).^2+(z-zo(1)).^2<ro(1)^2 );
    for j = 1:length(ind)
        c(iii) = icf;
        iii = iii+1;
    end

    % fully absorbing molecule
    % Absorbed molecules do not move anymore
    x(ind) = [];
    y(ind) = [];
    z(ind) = [];
end
