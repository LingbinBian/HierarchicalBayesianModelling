% Write memberships (labels) of nodes, and edges (adjacency matrix) to .node and .edge files for BrainNet Viewer.

% Version 1.0
% 7-Jun-2020
% Copyright (c) 2020, Lingbin Bian
clear
clc

L_state=11;

session_n=1;
if session_n==1
   cd 'Results/real/LR'
end
if session_n==2
   cd 'Results/real/RL'
end
load('grouplevel_data.mat');  
load('grouplevel_results.mat');
spar_level=5;
N=100;
% esti_grouplabel=zeros(N,11);
% for t=1:L_state
%     for i=1:N
%         for j=1:12
%             if R_esti_max{1,t}(i,j)~=0
%                 esti_grouplabel(i,t)=j;
%             end
%         end
%     end      
% end


% data_path = fileparts(mfilename('fullpath'));
% if datatype==0
%    group_path=fullfile(data_path,['Results/synthetic/','n',num2str(n_s),'/grouplevel_est']);
%    save(group_path);
% elseif datatype==1
%    if session_n==1
%        group_path=fullfile(data_path,['Results/real/LR/','grouplevel_est']);
%    elseif session_n==2
%        group_path=fullfile(data_path,['Results/real/RL/','grouplevel_est']);
%    end
%    save(group_path);    
% end

if datatype==1
    if session_n==1
        load('LR_meanconnectivity.mat')
    elseif session_n==2
        load('RL_meanconnectivity.mat')
    end
end

for t=1:L_state
    Node_ROI=dlmread(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node']);
    Node_ROI(:,4)=label_group_esti(:,t);
    dlmwrite(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node'],Node_ROI,'delimiter','\t')
    dlmwrite(['sparsity_',num2str(spar_level),'/Weighted_t',num2str(localmin_t(t)),'.edge'],ave_adj{t},'delimiter','\t')
   
     BrainNet_MapCfg(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node'],...
         ['sparsity_',num2str(spar_level),'/Weighted_t',num2str(localmin_t(t)),'.edge'],...
         'BrainMesh_ICBM152_smoothed.nv',...
         ['sparsity_',num2str(spar_level),'/Brainnet_setup_t',num2str(localmin_t(t)),'.mat'],...
         ['sparsity_',num2str(spar_level),'/network_t',num2str(localmin_t(t)),'.fig']);
     saveas(gcf,['sparsity_',num2str(spar_level),'/network_t',num2str(localmin_t(t)),'.fig'])
   
end
cd ..
