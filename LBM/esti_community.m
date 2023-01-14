function [Z_chain,K_chain,K,z] = esti_community(x)
% 1st level modelling
% This function estimates K and z of a single subject 
%
% Version 1.0
% 9-March-2021
% Copyright (c) 2021, Lingbin Bian

N=35;
Itera=2000;
% Prior hyper-parameters 
nu=3;
rho=0.02;
xi=0;
kappa_sq=1;

priorpra=struct('nu',nu,...
                'rho',rho,...
                'xi',xi,...
                'kappa_sq',kappa_sq,...
                'Itera',Itera); 
            
K_ini=5;
% MCMC Allocation sampler
[Z_chain,prob_chain,accep_r_array,K_chain]=MCMC_allocation_AE(x,K_ini,priorpra);

burnin_ite=500;
S=400;
autocorre_time=3;
K_pos=zeros(1,S);
z_pos=zeros(N,S);


for s=1:S
  %  latent_chain=gibbs_sampling(x,K,priorpra);
  % latent_pos{s}=latent_chain(:,5);
   z_pos(:,s)=Z_chain(:,burnin_ite+autocorre_time*s);
   K_pos(1,s)=K_chain(:,burnin_ite+autocorre_time*s);
  
end
   latent_vector=labelswitch(z_pos);  % label switching
   
   % Estimate z (the most frequent value)
   latent_pos=latent_vector';  
   [Au,ia,ic] = unique(latent_pos,'rows','stable');
   Counts = accumarray(ic, 1);
   Out = [Counts Au];
   output=sortrows(Out,1,'descend'); % sort in descend
   z=output(1,2:end)'; % the first row is the most frequent
   % Estimate K (the most frequent value)
   K=mode(K_pos);

end

