% global Pmax D L d;
function fitness = computedFitness(C,P,K)
    global Pmax;
    % 计算个体的适值
    TBS = TBsizeTable2get;
    [N,S] = size(C);
    X = getX(C,P,K);
    Dsum = 0;
    Psum = 0;
    for m=1:27
        for r = 1:110
            for n = 1:N
                for k = 1:K
                    Dsum = X(m,r,n,k)*TBS(r,m) + Dsum;
                end
            end
        end
    end
    for n = 1:N
        for s = 1:S
            if(P(n,s) > 0)
                Psum = P(n,s)*Pmax(n) + Psum;
            end
        end
    end
    fitness = Dsum/Psum;
end
function sinr = computedSINR( C,P,k )
    global Pmax D L;
    %计算一个设备的SINR
    bit=2;
    [N,S] = size(C);
    [n,s] = find(C==k);
    bottomLeft = 0;
    for m = 1:N
        if(m~=n)
             bottomLeft = bottomLeft + P(m,s)*Pmax(m)*(D(m,k))^-4;
         end
    end
    sinr = (P(n,s)*Pmax(n)*(D(m,k))^-4)/(bottomLeft + (Pmax(n)*(L(n))^-4)/bit);
end
function SINR = computedSINRArray(C,P,K)
%计算一个个体下的所有设备的SINR
    SINR = zeros(1,K);
    for k = 1:K
        SINR(k) = computedSINR(C,P,k);
    end
end
% function A = computedGarma(C,K)
% % 计算A矩阵
% % 输入：信道分配方案、设备总数
% % 输出：每个个体对应的garma矩阵
%     [N,S] = size(C);
%     A = zeros(N,K,S);
%     for k = 1:K
%         [n,s] = find(C==k);
%         A(n,k,s) = 1;
%     end
% end
function MCS = computedMCSArray(SINR)
% 输入：个体SINR分配数组
% 输出：个体MCS分配数组
    K = length(SINR);
    SIG=[-3.4,-2.7,-1.7,-1,0,1,2,2.9,3.8,4,4.4,5.4,6.4,7.4,8.2,8.9,9.7,10.3,11.3,12.1,13,14,15,15.9,16.7,17.9,18.8];
    MCS = zeros(1,K);
    for i = 1:K
        MCS(i) = length(SIG(SIG<=SINR(i)));
    end
    
end
function RB = computedRBByMCS(MCS)
    global d;
    % 输入：MCS,d(速率)
    K = length(MCS);
    RB = zeros(1,K);
    TBS = TBsizeTable2get;
    for i = 1:K
        TBk=TBS(:,ceil(MCS(i)));
        temp=find(TBk>=d(i));
        if(temp)
            RB(i)=temp(1);
        else
            RB(i)=0;
        end
    end
end
function X = getX(C,P,K)
    [N,S] = size(C);
    X = zeros(27,110,N,K);
    SINR = computedSINRArray(C,P,K);
    MCS = computedMCSArray(SINR);
    RB = computedRBByMCS(MCS);
    for k = 1:K
        [n,s] = find(C==k);
        m = MCS(k);
        r = RB(k);
        X(m,r,n,k) = 1;
    end
end




