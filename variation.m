function [ Gc,Gp ] = variation( Gc,Gp,K )
%  对种群进行变异操作
    [N,S,Gsize] = size(Gc);
    for g = 1:Gsize
        for n = 1:N
            rnum = rand(1);
            if rnum < 0.1
                s = randperm(S,1);
                if s~=0
                    Gc(n,s,g) = 0;
                    Gp(n,s,g) = 0;
                else
                    k = randperm(K,1);
                    Gc(n,s,g) = k;
                    Gp(n,s,g) = 0.1;
                end
            end
        end
    end
end

