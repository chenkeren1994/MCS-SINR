function [C1,C2,C3,C4,P1,P2,P3,P4]= multi_point_crossing(C1,C2,P1,P2)

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