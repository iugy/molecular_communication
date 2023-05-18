clc; clear; close all;

 DIM = 2^26;
 cicles=1;
 randForCicle = DIM;
 T = [];
 R = [];
 while(randForCicle~=1)
    %/* Generating */
    "cicles=" + num2str(cicles) + ", randForCicle=" + num2str(randForCicle)
    R = [R randForCicle];
    x= zeros(1,randForCicle);
    tic
    for i=1:cicles %( i=0; i<cicles; i++ )
        x = x + randn(1,randForCicle);%vsRngGaussian( VSL_RNG_METHOD_GAUSSIAN_BOXMULLER2, streamn, randForCicle, rn, 5.0f, 2.0f );
    end
    t = toc
    T=[T t];
    %printf("(%d, %d): %0.2lf\n", cicles, randForCicle, ((double)t)/CLOCKS_PER_SEC);
    randForCicle= randForCicle/2;
    cicles= cicles*2;
 end

 semilogx(R, T);