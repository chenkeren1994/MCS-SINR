function [ Gc, Gp, result ] = PSO( Gc, Gp, K, gen )
% 输入：种群（包含信道和功率）,设备数,进化代数
% 输出：新种群
   [N,S,sizepop] = size(Gp);
   pop = Gp;
   V = zeros(N,S,sizepop);
   fitness = zeros(1,sizepop);
   result = zeros(1,sizepop);
   Vmax = 0.1;
   Vmin = -0.1;
   
   for i = 1:sizepop
       V(:,:,i) = 0.1*rands(N,S);
       fitness(i) = computedFitness(Gc(:,:,i),pop(:,:,i),K);
   end
   [bestfitness,bestindex]=max(fitness);
   
   zbest=pop(:,:,bestindex);
   gbest=pop;
   fitnessgbest=fitness;
   fitnesszbest=bestfitness;
   
   for i = 1:gen
       for j = 1:sizepop
           V(:,:,j)=V(:,:,j)+rand.*0.3.*(gbest(:,:,j)-pop(:,:,j))+rand.*0.3.*(zbest-pop(:,:,j));
           V(V(:,:,j)>Vmax)=Vmax;
           V(V(:,:,j)<Vmin)=Vmin;
           
           pop(:,:,j)=pop(:,:,j)+0.5*V(:,:,j);
           
           temp = pop(:,:,j);
           
           temp(temp<0) = 0;
           
           pop(:,:,j) = temp;
           
           
           
           % 修复功率
           for n = 1:N
                sumP = sum(pop(n,:,j));
                for s = 1:S
                    if(pop(n,s,j)~=0)
                        pop(n,s,j) = pop(n,s,j)/sumP;
                    end
                end
           end
           
           fitness(j)=computedFitness(Gc(:,:,j),pop(:,:,j),K);
           
       end
       
       for j = 1:sizepop
           if fitness(j)>fitnessgbest(j)
                gbest(:,:,j)=pop(:,:,j);
                fitnessgbest(j)=fitness(j);
           end
        
           if fitness(j)>fitnesszbest
                zbest=pop(:,:,j);
                fitnesszbest=fitness(j);
           end
       end
       
       Gp = pop;
       disp(i);
%        result(i)=fitnesszbest;
       
   end
   
end

