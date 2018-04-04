function [Gc,Gp] = choice( C1,P1,K )
% 轮盘赌选择
% 输入：交叉后的种群，规模2m
% 输出：选择后的种群规模m
    [N,S,GSize] = size(C1);
    M = GSize;
    m = M/2;
    Gc = zeros(N,S,m);
    Gp = zeros(N,S,m);
    t = zeros(1,M);
    
    for g = 1:M
        t(g) = computedFitness(C1(:,:,g),P1(:,:,g),K);
%         t(g) = randperm(100,1);
    end
    
    % 将 {[粒子]，适值}放入元胞数组中
    for i = 1:M
        GcCeil{i} = {C1(:,:,i),t(i)};
        GpCeil{i} = {P1(:,:,i),t(i)};
    end
    GcCeil = sortCeil(GcCeil);
    GpCeil = sortCeil(GpCeil);
    for i = 1:m
        Gc(:,:,i) = GcCeil{i}{1};
        Gp(:,:,i) = GpCeil{i}{1};
    end
end
function G2 = sortCeil(G1)
    % 将元胞数组按照适值大小进行排序，并返回排序后的元胞数组
    len = size(G1);
    M = len(2);
    for i = 1:M
        maxIndex = i;
        for j = (i+1):M
            if G1{j}{2} > G1{maxIndex}{2}
                maxIndex = j;
            end
        end
        temp = G1{i};
        G1{i} = G1{maxIndex};
        G1{maxIndex} = temp;
    end
    G2 = G1;
end


