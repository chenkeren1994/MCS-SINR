function [Gc,Gp] = multi_point_crossing(C,P)
% 输入：信道种群和功率种群，容量为m
% 输出：交叉后的信道种群功率种群，容量为2m
    [N,S,GSize] = size(C); % 返回基站数、信道数和种群容量
    
    %初始化种群
    Gc = zeros(N,S,2*GSize);
    Gp = zeros(N,S,2*GSize);
    randNum = 1:GSize;
    % 对种群中每个个体进行交叉操作
    while(~isempty(randNum))
        %在[1：length(randNum)]数组中随机取两个数，并且在取过后将其删除
        rand = randsample(length(randNum),2);
        i1 = rand(1);
        i2 = rand(2);
        g1 = randNum(i1);
        g2 = randNum(i2);
        randNum([i1,i2])=[];
        C1 = C(:,:,g1);
        C2 = C(:,:,g2);
        P1 = P(:,:,g1);
        P2 = P(:,:,g2);
        [C1,C2,C3,C4,P1,P2,P3,P4] = multi_point_crossing_vector(C1,C2,P1,P2);
        Gc(:,:,g1) = C1;
        Gc(:,:,g2) = C2;
        Gc(:,:,g1+GSize) = C3;
        Gc(:,:,g2+GSize) = C4;
        Gp(:,:,g1) = P1;
        Gp(:,:,g2) = P2;
        Gp(:,:,g1+GSize) = P3;
        Gp(:,:,g2+GSize) = P4;
    end
end
function [C1,C2,C3,C4,P1,P2,P3,P4]= multi_point_crossing_vector(C1,C2,P1,P2)

% 功能：对个体进行交叉操作
% 输入：个体1的信道分配矩阵和功率分配矩阵，个体2的信道分配矩阵和功率分配矩阵
% 输出：原个体1和个体2的信道分配矩阵和功率分配矩阵，和交叉后产生的两个新个体
    siz = size(C1);
    N = siz(1);
    S = siz(2);
    C3 = zeros(N,S);
    C4 = zeros(N,S);
    P3 = zeros(N,S);
    P4 = zeros(N,S);
    for i = 1:N
        cross_point = randi([1,S]);
        [a,b] = swap(C1(i,:),C2(i,:),cross_point);
        [c,d] = swap(P1(i,:),P2(i,:),cross_point);
        C3(i,:) = a;
        C4(i,:) = b;
        P3(i,:) = c;
        P4(i,:) = d;
    end
end
 function [b1,b2] = swap( a1,a2,k )
 % 输入：两个向量，交叉点
 % 输出：交叉后的两个新向量
     for i = k:length(a1)
          temp = a1(i);
         a1(i) = a2(i);
         a2(i) = temp;
     end
     b1 = a1;
     b2 = a2;
 end
 
