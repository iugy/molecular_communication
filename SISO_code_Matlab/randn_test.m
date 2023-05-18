clc; clear; close all;

DIM = 10000000;
N=1000;
x=0;%zeros(1,N);
tic
for i=1:DIM
    x = x + randn(1,1);
end
toc