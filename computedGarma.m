% function garma = computedGarma(C,K)
% % 计算gama矩阵
% % 输入：信道分配方案、功率分配方案、设备总数
% % 输出：每个个体对应的garma矩阵
%     [N,S] = size(C);
%     garma = zeros(N,K,S);
%     for k = 1:K
%         [n,s] = find(C==k);
%         garma(n,k,s) = 1;
%     end
% end