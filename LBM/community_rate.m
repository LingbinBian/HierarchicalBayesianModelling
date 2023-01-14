function [rate] = community_rate(K_g)
% 2nd level modelling (estimate the rate: lambda)
% This function models the number of communities for the group
%
% Version 1.0
% 9-March-2021
% Copyright (c) 2021, Lingbin Bian

[S,N_state]=size(K_g);

% gamma parameters
a=0.2;
b=0.1;
N_simu=1000;
rate=zeros(N_simu,N_state);

for ds=1:N_state 
   for i=1:N_simu
       rate(i,ds)=gamrnd(sum(K_g(:,ds)+a),1/(S+1/b));
   end
end

