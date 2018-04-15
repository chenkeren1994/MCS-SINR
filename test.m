global Pmax;
global D;
global L;
global d;
% 
%  G = 40;% 种群容量
%  N = 10;% 基站数
%  S = 12;% 信道数
%  K = 50;% 用户数
%  
%  gNumber = 500;
%  
%  Pmax=csvread('./data/pmax.csv');
%  d = csvread('./data/need.csv');
%  L = csvread('./data/l.csv');
%  D = csvread('./data/distance.csv');
%  fitness = zeros(1,G);
%  [Gc,Gp] = initPop(G,N,S,K);
%  for g = 1:G
%      fitness(g) = computedFitness(Gc(:,:,g),Gp(:,:,g),K);
%  end

 Pmax=csvread('./data/pmax.csv');
 d = csvread('./data/need.csv');
 L = csvread('./data/l.csv');
 D = csvread('./data/distance.csv');
% drawPicture(5000);