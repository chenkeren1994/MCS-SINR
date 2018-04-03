 global Pmax;
 global D;
 global L;
 global d;

 G = 40;% 种群容量
 N = 10;% 基站数
 S = 12;% 信道数
 K = 50;% 用户数
 
 Pmax=[100,200,150,110,120,300,100,400,230,210];
 d = 10+300*rand(1,50);
 L = [10,20,15,11,12,30,10,40,23,21];
 D = 5+40*rand(N,K);
 [Gc,Gp] = initPop(G,N,S,K);
 C = Gc(:,:,3);
 P = Gp(:,:,3);
 fitness = computedFitness(C,P,K);