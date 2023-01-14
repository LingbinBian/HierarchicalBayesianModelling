% Calculate local fitting for individual adjacency matrix.
% 
% Version 1.0
% 9-March-2021
% Copyright (c) 2021, Lingbin Bian
% -------------------------------------------------------------------------
clear
clc
close all
datatype=1;

if datatype==0
    n_s=1;
    %  localmin_t=[36,67,91,116,147]; % n_s: 0.3162
    %  localmin_t=[36,66,91,116,146]; % n_s: 0.5623
      localmin_t=[36,66,92,116,146]; % n_s: 1    
    subjects=load('synthetic_id.txt');
    W=9;  % half of window size
    K_min=[4,5,3,5,4];
    session_n='';
   
elseif datatype==1
    session_n=2;
    if session_n==1
        localmin_t=[41,76,140,175,239,278,334,375];
    end
    if session_n==2
        localmin_t=[41,77,139,175,236,275,334,376];
    end
    subjects=load('subject.txt');
    W=15;  % half of window size
    K_min=[3,3,3,3,3,3,3,3,3,3,3];  % select K
    n_s=' ';
end

local_fit=zeros(1,16);  
K_trial=3:18;   % K trial
L_localmin=length(localmin_t);
local_fit_aveadj=zeros(L_localmin,16);

S=200;  % replication number
N_subj=100;   % number of subjects
N=35;   % number of nodes

group_adj=cell(N_subj,1); % group of adjacency matrix


% Local averaged adjacency matrix
for s=1:N_subj
    fprintf('Adjacency of subject: %d\n',s)
    subid=num2str(subjects(s));
    [group_adj{s,1},true_latent]=local_adj(datatype,subid,session_n,n_s,localmin_t,K_min,W);
end

n_simul=1;
local_fit_multi=cell(n_simul,1);
for n=1:n_simul
    for l=1:L_localmin 
        fprintf('Processing state t= %d\n',localmin_t(l))
        for j=1:16
        T=L_localmin;
        K=K_trial(j);
        netpara=struct('T',T,...
                   'N',N,...
                   'K',K,...
                   'W',W);
        local_fit(1,j)=posterior_predictive(group_adj{1,1},netpara,l,S);
        end
        local_fit_aveadj(l,:)=local_fit;
        local_fit=zeros(1,16);  
    end
    local_fit_multi{n,1}=local_fit_aveadj;
end

fit_matrix=zeros(L_localmin,16);
ave_fit=zeros(1,n_simul);
for i=1:L_localmin
    for j=1:16   
        for n=1:n_simul
            ave_fit(1,n)=local_fit_multi{n,1}(i,j);
        end
        fit_matrix(i,j)=mean(ave_fit); 
        ave_fit=zeros(1,n_simul);
    end
end

Localfit_path = fileparts(mfilename('fullpath'));
if isempty(Localfit_path), Localfit_path = pwd; end

if datatype==1
    if session_n==1
       Localfit_path=fullfile(Localfit_path,'Local_fitting_real_LR/localfit_individualadj');
       save(Localfit_path);
    end
    if session_n==2
       Localfit_path=fullfile(Localfit_path,'Local_fitting_real_RL/localfit_individualadj');
       save(Localfit_path);
    end
end
if datatype==0
Localfit_path=fullfile(Localfit_path,['Local_fitting_synthetic/n',num2str(n_s),'/localfit_individualadj']);
save(Localfit_path);
end




