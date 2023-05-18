clc; close all; clear;

num = 10;

sv = load(['res_dt_1e-07_d2_4e-06_noINT_prova_' num2str(num) '.mat']);
c = sv.c;
dt = sv.dt;
cc = [];
T = sv.T;
xo = sv.xo;
yo = sv.yo;
zo = sv.zo;
N = sv.N;
ro = sv.ro;
D = sv.D;
for i=1:size(c,1)
    cx = c(i,:);
    cx(cx==0)=[];
    cc = timeInterleave(cc, cx);
end
X = 0;
Y = 0;
for j=1:length(cc)
    t = cc(j)*dt;
    ind = find(X == t);
    if(isempty(ind))
        Y = [Y 1];
        X = [X t];
    else
        Y(ind)=Y(ind)+1;
    end
end
figure();
%plot(X,temporalSum(X,Y,10*mean(diff(X)))/num);
plot(X, cumsum(Y)/num);



%% Functions
function [A] = temporalSum(X, Y , t)
    A=zeros(size(X));
    for i=1:length(X)
        A(i) = sum(Y(X>=X(i)-t/2 & X<=X(i)+t/2));
    end
end

function [X] = timeInterleave(A,B)
    X = [];
    while(~isempty(A) && ~isempty(B))
        if(A(1)<B(1))
            X=[X A(1)];
            A(1)=[];
        else
            X=[X B(1)];
            B(1)=[];
        end
    end
    if(~isempty(A))
        X=[X A];
    end
    if(~isempty(B))
        X=[X B];
    end
end