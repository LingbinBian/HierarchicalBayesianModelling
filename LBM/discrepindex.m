function [ discindex,para_infer ] = discrepindex( AdjaCell,netpara,S,thres)
% This function generates the discrepancy index.
% Version 1.1 | Lingbin Bian, 
% School of Mathematics, Monash University
% 11-Aug-2019

T=netpara.T;
W=netpara.W;
discindex=zeros(1,T);
para_infer=cell(1,T);

if thres==0
   for t=(W+1):(T-W)    
       fprintf('time step=%d\n',t)
       [discindex(t),para_infer{t}]=posterior_predictive(AdjaCell,netpara,t,S);
   end
elseif thres==1
    for t=(W+1):(T-W)    
       fprintf('time step=%d\n',t)
       [discindex(t),para_infer{t}]=posterior_predictive_SBM(AdjaCell,netpara,t,S);
    end
end

end

