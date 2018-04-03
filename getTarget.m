function t = getTarget( C,P )
% 输入：每个个体的信道分配矩阵和功率分配矩阵
% 输出：每个个体的适应度值
    N=8;
    D=[4,5,6,7,8,9,4,5,6,3,4,5,6,7,8,9,4,5,6,3];
    S=12;
    K=20;
    T = TBsizeTable2get;
    Sig = getSINR(C,P);
    MCS = getMCSfromSINR(Sig);
    RB = getRBfromMCS(MCS,D);
    x = getX(C,MCS,RB);
    topSum = 0;
    bottomSum = 0;
    for n=1:N
        for k=1:K
            for r=1:11
                for m=1:27
                    topSum = topSum + x*T(r,m);
                end
            end
        end
    end
    
    for k=1:K
        bottomSum = bottomSum + getSingleSINR(k,C,P);
    end
    t = topSum/bottomSum;

end
function x = getX(C,mcs,RB)
    N=8;
    S=12;
    K=20;
    x = zeros(K,N,27,11);
    for k = 1:K
        [n,s] = find(C==k);
        m = mcs(k);
        r = RB(k);
        x(m,r,n,k) = 1;
    end
end
function RB = getRBfromMCS(mcs)
% 输入：设备的MCS分配数组和设备的传输速率需求分配数组
% 输出：设备的TB分配方案
    D=[4,5,6,7,8,9,4,5,6,3,4,5,6,7,8,9,4,5,6,3];
    N=8;
    S=12;
    K=20;
    TBS = TBsizeTable2get;
    rb=zeros(1,K);
    for i = 1:K
        TBk=TBS(:,ceil(mcs(i)));
        temp=find(TBk>=D(i));
        rb(i)=temp(1);
    end
    RB=rb;
end
function MCS = getMCSfromSINR(s)
    % 输入：所有设备的SINR
    % 输出：所有设备的MCS
    N=8;
    S=12;
    K=20;
    SIG=[-3.4,-2.7,-1.7,-1,0,1,2,2.9,3.8,4,4.4,5.4,6.4,7.4,8.2,8.9,9.7,10.3,11.3,12.1,13,14,15,15.9,16.7,17.9,18.8];
    MCS = zeros(1,K);
    for i = 1:K
        MCS(i) = length(SIG(SIG<=s(i)));
    end
end
function Sig = getSINR(C,P)
    %得到SINR分配数组
    N=8;
    S=12;
    K=20;
    Sig = zeros(1,K);
    for i = 1:K
        Sig(i) = getSingleSINR(i,C,P);
    end
end

function sk = getSingleSINR(k,C,P)
%求得每个设备k的SINR
    N=8;
    S=12;
    K=20;
    sum = 0;
    A = zeros(N,K,S);
    for k = 1:K
        [n,s] = find(C == k);
        A(n,k,s) = 1;
    end
    for s = 1:S
        for n = 1:N
            sum = sum + A(n,k,s)*getGarma(n,k,s,P);
        end
    end
    sk = sum;
end

function garma = getGarma(n,k,s,P)
    Pmax = [1000,1000,1000,1000,1000,1000,1000,1000];
    N=8;
    S=12;
    K=20;
    bottomleftsum = 0;
    for m = 1:N
        if(m~=n)
            bottomleftsum = bottomleftsum + P(m,s)*Pmax(m);
        end
    end
    garma = (P(n,s)*Pmax(n))/(bottomleftsum + Pmax(n));
end
