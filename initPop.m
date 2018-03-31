function [ Gc,Gp ] = initPop( GSize,N,S,K)
%输入：种群个体总数，基站总数，信道最大数，设备数
%输出：初始化的种群，包括两个三维数组，即信道和功率
    Gc = zeros(N,S,GSize);
    Gp = zeros(N,S,GSize);
    for i = 1:GSize
        [c,p] = initOne(N,S,K);
        Gc(:,:,i) = c;
        Gp(:,:,i) = p;
    end
end

function [C,P] = initOne(N,S,K)
% 输入：基站总数，信道最大数，设备数
% 输出：个体的信道分配矩阵和功率分配矩阵
    C = zeros(N,S);
    for k = 1:K
        i = randi([1,N]);
        j = randi([1,S]);
        while(C(i,j)~=0)
            i = randi([1,N]);
            j = randi([1,S]);
        end
        C(i,j) = k;
    end
    %根据信道分配矩阵，初始化功率分配矩阵
    temp = setOne(C);
    
    %功率分配有问题，日后再说***************************
    P = temp.*rand(N,S);
end

function b = setOne(a)
%将矩阵中不为0的值都设为1
    siz = size(a);
    h = siz(1);
    w = siz(2);
    for i = 1:h
        for j = 1:w
            if(a(i,j) ~= 0)
                a(i,j) = 1;
            end 
        end
    end
    b = a;
end

