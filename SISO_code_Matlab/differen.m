clc; clear; close all;


n=100000;
% syms x;
% syms D(x) [1,n+1];
% 
% D0(x) = sqrt(-2*log(x));
% D1(x) = diff(D0);
% D2(x) = diff(D1);
% D3(x) = diff(D2);
% D4(x) = diff(D3);
% D5(x) = diff(D4);
% 
% Y(x) = D0(0.5) ...
%         + D1(0.5)*(x-0.5) ...
%         + D2(0.5)*(x-0.5)^2/factorial(2) ...
%         + D3(0.5)*(x-0.5)^3/factorial(3) ...
%         + D4(0.5)*(x-0.5)^4/factorial(4) ...
%         + D5(0.5)*(x-0.5)^5/factorial(5); 
       
y= zeros(1,n);
z= zeros(1,n);
tic
for i= 1:n/2
    u1=rand();
    u2=rand();
    %y(i) = Y(u1)*cos(2*pi*u2);
    y(2*i-1)=(1.1774-1.6986*(u1-0.5)+0.4733*(u1-0.5)^(2)-1.5820*(u1-0.5)^(3)+1.0198*(u1-0.5)^(4)-3.3284*(u1-0.5)^(5))...
        *cos(2*pi*u2);
    y(2*i)=(1.1774-1.6986*(u1-0.5)+0.4733*(u1-0.5)^(2)-1.5820*(u1-0.5)^(3)+1.0198*(u1-0.5)^(4)-3.3284*(u1-0.5)^(5))...
        *sin(2*pi*u2);
    %)...
        
end
toc
tic
for i= 1:n
    u1=rand();
    u2=rand();
    z(i) = sqrt(-2*log(u1))*cos(2*pi*u2);
    
end
toc

histogram(y, 100);
figure();
histogram(z,100);