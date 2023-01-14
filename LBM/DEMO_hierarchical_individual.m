% Hierarchical Bayesian Modelling (Gibbs & M3 & AE move)
% Individual level modelling
%
% Version 1.0
% 7-March-2021
% Copyright (c) 2021, Lingbin Bian
% -------------------------------------------------------------------------
clear
clc
% -------------------------------------------------------------------------
% Load data 
% Data type
datatype=0;   % 1: real data, 0: synthetic data

if datatype==1
    session_n=1;
    n_s='';
    subjects=load('subject.txt');
    if session_n==1
        localmin_t=[41,76,107,140,175,206,239,278,306,334,375];
    elseif session_n==2       
        localmin_t=[49,77,99,139,175,209,236,275,305,334,376];
    end
    K_min=[6,6,6,6,6,6,6,6,6,6,6];  % make an assumption of K
    W=10;
elseif datatype==0
    session_n='';
    n_s=0.5623;
    subjects=load('synthetic_id.txt');   
    vari=0; % fixed true community structure
    hrf_ind=1;
    if n_s==0.3162
       localmin_t=[43,75,98,125,154]; % n_s: 0.3162; SNR=10dB; with hrf
    elseif n_s==0.5623
       localmin_t=[44,74,98,130,154]; % n_s: 0.5623; SNR=5dB; with hrf
    else
       localmin_t=[]; % n_s: 1; SNR=0dB; with hrf, fail to detect change points
    end
    K_min=[4,5,3,5,4];
    W=10;
end

N_subj=100;
S=200;
L_localmin=length(localmin_t);

group_adj=cell(N_subj,1); % group of adjacency matrix

K_g=zeros(N_subj,L_localmin); % group of estimated K
z_g=cell(N_subj,L_localmin); % group of estimated z

K_chain=cell(N_subj,L_localmin);
Z_chain=cell(N_subj,L_localmin);

% Local averaged adjacency matrix
for s=1:N_subj
    fprintf('Adjacency matrix of subject: %d\n',s)
    subid=num2str(subjects(s));
    [group_adj{s,1},true_latent]=local_adj(datatype,subid,session_n,n_s,localmin_t,K_min,W,vari,hrf_ind);
end

% -------------------------------------------------------------------------
% Adjacency matrix

W=10; % half of window size
M=10; % margin size
N=35; 
if datatype==0
    N_state=5;
elseif datatype==1    
    N_state=11;
end
for s=1:N_subj
    fprintf('subject: %d\n',s)
    for ds=1:N_state
      [Z_chain{s,ds},K_chain{s,ds},K_g(s,ds),z_g{s,ds}] = esti_community(group_adj{s,1}{1,ds});      
    end
end

% Label switching
group_labels=zeros(N,N_subj*N_state);
for ds=1:N_state
    for s=1:N_subj
       group_labels(:,N_subj*(ds-1)+s)=z_g{s,ds};   
    end
end
group_labels=labelswitch(group_labels);
for ds=1:N_state
    for s=1:N_subj
       z_g{s,ds}=group_labels(:,N_subj*(ds-1)+s);   
    end
end

% Save the results of individual-level modelling

data_path = fileparts(mfilename('fullpath'));
if datatype==0
    if hrf_ind==1
        group_path=fullfile(data_path,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/grouplevel_data']);
    elseif hrf_ind==0
        group_path=fullfile(data_path,['Hierarchical/synthetic/','n',num2str(n_s),'/grouplevel_data']);
    end
   save(group_path);
elseif datatype==1
   if session_n==1
       group_path=fullfile(data_path,['Hierarchical/real/LR/','grouplevel_data']);
   elseif session_n==2
       group_path=fullfile(data_path,['Hierarchical/real/RL/','grouplevel_data']);
   end
   save(group_path);    
end

% Visualize latent label vectors ------------------------------------------
mat_labels=zeros(N,N_subj);
for s=1:N_state
   figure
   for n=1:N_subj    
        mat_labels(:,n)=z_g{n,s};  
   end
    imagesc(mat_labels(:,:))
    colormap(color_type(mat_labels(:,:)));
    colorbar_community_K(unique(mat_labels(:,:)))
    title(['State',' ',num2str(s)],'fontsize',16) 
    xlabel('Subject','fontsize',16) 
    ylabel('Node','fontsize',16)   
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
    mat_labels=zeros(N,N_subj);
    if datatype==0
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]);
    elseif datatype==1
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]);
    end
    if datatype==0
        saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/group_latent_labels_',num2str(s),'.fig'])
    elseif datatype==1
        if session_n==1
            saveas(gcf,['Hierarchical/real/LR/','group_latent_labels_',num2str(s),'.fig'])
        elseif session_n==2
            saveas(gcf,['Hierarchical/real/RL/','group_latent_labels_',num2str(s),'.fig'])
        end
    end
end










