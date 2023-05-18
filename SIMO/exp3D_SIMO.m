function [c]=exp3D_SIMO(N,T,dt,var,dims)
x = zeros(1,N);
y = zeros(1,N);
z = zeros(1,N);
n = length(dims);
c = zeros(round(T/dt),n);
SQRT_VAR = sqrt(var);

%change from array of structs to struct of arrays to ease the computation
fields = fieldnames(dims);
for j = 1:numel(fields)
    for i = 1:n
        DIMS.(fields{j})(i) = dims(i).(fields{j});
    end
end

for icf =2:round(T/dt)
    
    Dx = SQRT_VAR*randn(size(x));
    Dy = SQRT_VAR*randn(size(y));
    Dz = SQRT_VAR*randn(size(z));
    x = x + Dx;
    y = y + Dy;
    z = z + Dz;
    
    [rx,ind] = find( (x-DIMS.xo').^2 + (y-DIMS.yo').^2 + (z-DIMS.zo').^2 < DIMS.ro'.^2 );
    c(icf,:) = groupcounts([rx; (1:n)'])-1;

    % fully absorbing molecule
    % Absorbed molecules do not move anymore
    x(ind) = [];
    y(ind) = [];
    z(ind) = [];

end
