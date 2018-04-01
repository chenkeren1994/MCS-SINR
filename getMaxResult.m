function  [resultC,resultP,t] = getMaxResult(Gc,Gp)
% 从进化后的种群中选出适值最大的个体，并保存其分配方案和适值
    resultC = Gc(:,:,1);
    resultP = Gp(:,:,1);
    t = getTarget(resultC,resultP);
end

