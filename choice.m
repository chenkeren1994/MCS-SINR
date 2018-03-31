function [Gc,Gp] = choice( C1,P1 )
% 轮盘赌选择
% 输入：交叉后的种群，规模2m
% 输出：选择后的种群规模m
    Gc = zeros(N,S,m);
    Gp = zeros(N,S,m);
    t = zeros(1,M);
    
    for g = 1:M
        t(g) = getTarget(C1(:,:,g),P1(:,:,g));
    end
    
end

