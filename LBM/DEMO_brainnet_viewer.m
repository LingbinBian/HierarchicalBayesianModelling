% Write memberships (labels) of nodes, and edges (adjacency matrix) to .node and .edge files for BrainNet Viewer.

% Version 1.0
% 7-Jun-2020
% Copyright (c) 2020, Lingbin Bian
clear
clc

L_localmin=11;

session_n=1;
if session_n==1
   cd 'Hierarchical/real/LR'
end
if session_n==2
   cd 'Hierarchical/real/RL'
end
load('grouplevel_data.mat');  
load('grouplevel_results.mat');
spar_level=10;

esti_grouplabel=zeros(35,11);
for t=1:L_localmin
    for i=1:35
        for j=1:10
            if R_esti_max{1,t}(i,j)~=0
                esti_grouplabel(i,t)=j;
            end
        end
    end
       
end


data_path = fileparts(mfilename('fullpath'));
if datatype==0
   group_path=fullfile(data_path,['Hierarchical/synthetic/','n',num2str(n_s),'/grouplevel_est']);
   save(group_path);
elseif datatype==1
   if session_n==1
       group_path=fullfile(data_path,['Hierarchical/real/LR/','grouplevel_est']);
   elseif session_n==2
       group_path=fullfile(data_path,['Hierarchical/real/RL/','grouplevel_est']);
   end
   save(group_path);    
end


for t=1:L_localmin   
    Node_ROI=dlmread(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node']);
    Node_ROI(:,4)=esti_grouplabel(:,t);
    dlmwrite(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node'],Node_ROI,'delimiter','\t')
    dlmwrite(['sparsity_',num2str(spar_level),'/Weighted_t',num2str(localmin_t(t)),'.edge'],esti_connectmean{t},'delimiter','\t')
   
    BrainNet_MapCfg(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node'],...
        ['sparsity_',num2str(spar_level),'/Weighted_t',num2str(localmin_t(t)),'.edge'],...
        'BrainMesh_Ch2withCerebellum.nv',...
        ['sparsity_',num2str(spar_level),'/Brainnet_setup_t',num2str(localmin_t(t)),'.mat'],...
        ['sparsity_',num2str(spar_level),'/network_t',num2str(localmin_t(t)),'.fig']);
    saveas(gcf,['sparsity_',num2str(spar_level),'/network_t',num2str(localmin_t(t)),'.fig'])
   
end
cd ..
