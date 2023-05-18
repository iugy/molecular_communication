function [c]=exp3D_SISO_PA(N,T,dt,var,xo,yo,zo,ro,beta)
x = zeros(1,N);
y = zeros(1,N);
z = zeros(1,N);
c = zeros(1,round(T/dt));
SQRT_VAR = sqrt(var);

RO = xo(1).^2 + yo.^2 + zo.^2;
cosb = cos(beta);

for icf =2:round(T/dt)
    
    Dx = SQRT_VAR*randn(size(x));
    Dy = SQRT_VAR*randn(size(y));
    Dz = SQRT_VAR*randn(size(z));
    x = x + Dx;
    y = y + Dy;
    z = z + Dz;
    
    ind = find( (x-xo(1)).^2+(y-yo(1)).^2+(z-zo(1)).^2<ro(1)^2 );
    X = x(ind) - xo(1);
    Y = y(ind) - yo(1);
    Z = z(ind) - zo(1);
    
%     inde = find();
    
    c(icf) = sum(-(X.*xo(1) + Y.*yo(1) + Z.*zo(1)) ./ (sqrt( (X.^2+Y.^2+Z.^2) .* (RO) ))>cosb,2);

    % fully absorbing molecule
    % Absorbed molecules do not move anymore
    x(ind) = [];
    y(ind) = [];
    z(ind) = [];
end