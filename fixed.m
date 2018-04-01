function [Gc,Gp] = fixed(Gc,Gp,K)
% 修正交叉后的种群
% K => 用户总数
    [N,S,GSize] = size(Gc);
    for g = 1:GSize
        for k = 1:K
            c = Gc(:,:,g);
            f = find(c==k);
            if (f)
                if(length(f)>1)
                    [n,s] = find(c==k);
                    for i = 2:length(f)
                        Gc(n(i),s(i),g) = 0;
                        Gp(n(i),s(i),g) = 0;
                    end
                end
            else
                n = randperm(N,1);
                s = randperm(S,1);
                while (c(n,s)~=0)
                    n = randperm(N,1);
                    s = randperm(S,1);
                end
                Gc(n,s,g) = k;
                Gp(n,s,g) = 0.2; % 稍后处理
            end
        end
    end
end
