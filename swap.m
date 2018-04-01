%  function [b1,b2] = swap( a1,a2,k )
%  % 输入：两个向量，交叉点
%  % 输出：交叉后的两个新向量
%      for i = k:length(a1)
%           temp = a1(i);
%          a1(i) = a2(i);
%          a2(i) = temp;
%      end
%      b1 = a1;
%      b2 = a2;
%  end
%  
