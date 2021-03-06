 global Pmax;
 global D;
 global L;
 global d;

 G = 40;% 种群容量
 N = 10;% 基站数
 S = 12;% 信道数
 K = 50;% 用户数
 gNumber = 100;
 
 Pmax=csvread('./data/pmax.csv');
 d = csvread('./data/need.csv');
 L = csvread('./data/l.csv');
 D = csvread('./data/distance.csv');
 
 fitness = zeros(1,gNumber);
 Rc = zeros(N,S,gNumber);
 Rp = zeros(N,S,gNumber);
 
 % 初始化种群
 [Gc,Gp] = initPop(G,N,S,K);
 
 for g = 1:gNumber
     % 交叉
     [Gc,Gp] = multi_point_crossing(Gc,Gp);
     
     % 变异
     
     [ Gc,Gp ] = variation( Gc,Gp,K );
     
     % 修正
     [Gc,Gp] = fixed(Gc,Gp,K);
     
     % 嵌套粒子群
     [Gc,Gp,result_pso] = PSO(Gc,Gp,K,10);
     
     % 选择
     [Gc,Gp] = choice(Gc,Gp,K);
     
     disp(g);
      
     [resultC,resultP,t] = getMaxResult(Gc,Gp,K);
     
     
     fitness(g) = t;
     Rc(:,:,g) = resultC;
     Rp(:,:,g) = resultP;
 end
 
 C = Rc(:,:,gNumber);
 P = Rp(:,:,gNumber);
 
 csvwrite('./output/fitness.csv',fitness);
 csvwrite('./output/gbestc.csv',C);
 csvwrite('./output/gbestp.csv',P);
 
 drawPicture(gNumber);
 
 