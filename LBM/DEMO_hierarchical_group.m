% Hierarchical Bayesian modelling
% Group-level modelling
%
% Version 1.0
% 10-March-2021
% Copyright (c) 2021, Lingbin Bian

clear
clc

datatype=0;

if datatype==0
    % n_s=0.3162;
     n_s=0.5623;
    % n_s=1;
    load(['Hierarchical/synthetic/n',num2str(n_s),'_hrf','/grouplevel_data.mat']);
elseif datatype==1
    session_n=1;
    if session_n==1
        load('Hierarchical/real/LR/grouplevel_data.mat');    
    elseif session_n==2
        load('Hierarchical/real/RL/grouplevel_data.mat'); 
    end
end

% Modelling latent labels
mat_labels=zeros(N,N_subj);
R_esti=cell(1,N_state);
R_esti_max=cell(1,N_state);
label_group_esti=zeros(N,N_state);
label_group_switched=zeros(N,N_state);
label_compare=cell(1,N_state);
vector_compare=zeros(N,2);


K=max(max(K_g));
N_simu=1000;

% Estimate assignment probability
for s=1:N_state
   for n=1:N_subj    
        mat_labels(:,n)=z_g{n,s};    
   end
   R_esti{1,s}=assign_esti(mat_labels,K,N_simu);
   mat_labels=zeros(N,N_subj);
end

for s=1:N_state
   R_esti_max{s}=mat_maxrow(R_esti{s});
end

for s=1:N_state
    [N,K_assign]=size(R_esti_max{s});
    for i=1:N
      for j=1:K_assign
          if R_esti_max{s}(i,j)~=0  
             label_group_esti(i,s)=j;
          end
      end
    end
end

K_esti=max(label_group_esti);

if datatype==0
    for j=1:N_state
        vector_compare(:,2)=label_group_esti(:,j);
        vector_compare(:,1)=true_latent(:,j+1);
        vector_compare=labelswitch(vector_compare);
        label_compare{1,j}=vector_compare;        
    end
    for j=1:N_state
        label_group_switched(:,j)=label_compare{1,j}(:,2);
    end

end


% Visualize assignment probability

for s=1:N_state
    figure
    imagesc(R_esti{s})
    colormap(pink);
    colorbar
    title(['State',' ',num2str(s)],'fontsize',16) 
    xlabel('k','fontsize',16) 
    ylabel('Node','fontsize',16)      
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
    if datatype==0
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]);
    elseif datatype==1
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]);
    end
    
    if datatype==0
        saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/assign_prob_state_',num2str(s),'.fig'])
    elseif datatype==1
        if session_n==1
            saveas(gcf,['Hierarchical/real/LR/','assign_prob_state_',num2str(s),'.fig'])
        elseif session_n==2
            saveas(gcf,['Hierarchical/real/RL/','assign_prob_state_',num2str(s),'.fig'])
        end
    end
end

% Visualize assignment probability (Max)

for s=1:N_state
   if datatype==0  
      figure      
   elseif datatype==1
      figure
   end 
   
   imagesc(R_esti_max{s})
   colormap(pink);
   colorbar
   title(['State',' ',num2str(s)],'fontsize',16) 
   xlabel('k','fontsize',16) 
   ylabel('Node','fontsize',16)    
   set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')


   if datatype==0
    set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]);
   elseif datatype==1
    set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]);
   end
   
   if datatype==0
       saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/assign_prob_max_state_',num2str(s),'.fig'])
   elseif datatype==1
       if session_n==1
           saveas(gcf,['Hierarchical/real/LR/','assign_prob_max_state_',num2str(s),'.fig'])
       elseif session_n==2
           saveas(gcf,['Hierarchical/real/RL/','assign_prob_max_state_',num2str(s),'.fig'])
       end
   end
end


% Visualize latent label vector

if datatype==0
figure  
for t=1:N_state
    subplot(1,N_state,t)
    visual_labels(label_group_esti(:,t),K_min)
    title('Estimation','fontsize',16)
end
set(gcf,'unit','normalized','position',[0.3,0.2,0.4,0.28]);
saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/Labels_esti.fig'])

figure  
for t=1:N_state
    subplot(1,N_state,t)
    visual_labels(label_compare{:,t}(:,2),K_min)
    title('Switched','fontsize',16)
end
set(gcf,'unit','normalized','position',[0.3,0.2,0.4,0.28]);
saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/Labels_switched.fig'])

figure
for t=1:N_state
    subplot(1,N_state,t)
    visual_labels(label_compare{:,t}(:,1),K_min)
    title('True','fontsize',16)
end
set(gcf,'unit','normalized','position',[0.3,0.2,0.4,0.28]);
% saveas(gcf,'Local_inference_synthetic/Labels_true.fig')
saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/Labels_true.fig'])
end

data_path = fileparts(mfilename('fullpath'));
if datatype==0
   group_results_path=fullfile(data_path,['Hierarchical/synthetic/','n',num2str(n_s),'_hrf','/grouplevel_results']);
   save(group_results_path);
elseif datatype==1
   if session_n==1
       group_results_path=fullfile(data_path,['Hierarchical/real/LR/','grouplevel_results']);
   elseif session_n==2
       group_results_path=fullfile(data_path,['Hierarchical/real/RL/','grouplevel_results']);
   end
   save(group_results_path,'R_esti_max','esti_connectmean','esti_connectvariance');    
end





% % Visualize connectivity mean
% figure
% 
% for s=1:N_state
%    if datatype==0  
%       subplot(2,3,s)
%    elseif datatype==1
%       subplot(3,4,s)
%    end 
%     imagesc(esti_connectmean{s})
%     colormap(turbo);
%     colorbar
%     title(['State',' ',num2str(s)],'fontsize',16) 
%     xlabel('Node','fontsize',16) 
%     ylabel('Node','fontsize',16)
%       
%     set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
% end
% 
% if datatype==0
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.45,0.4]);
% elseif datatype==1
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.55,0.6]);
% end
%         
% if datatype==0
%     saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'/group_connectmean_estimation.fig'])
% elseif datatype==1
%     if session_n==1
%         saveas(gcf,['Hierarchical/real/LR/','group_connectmean_estimation.fig'])
%     elseif session_n==2
%         saveas(gcf,['Hierarchical/real/RL/','group_connectmean_estimation.fig'])
%     end
% end
% 
% % Visualize connectivity variance
% figure
% 
% for s=1:N_state
%    if datatype==0  
%       subplot(2,3,s)
%    elseif datatype==1
%       subplot(3,4,s)
%    end 
%     imagesc(esti_connectvariance{s})
%     colormap(winter);
%     colorbar
%     title(['State',' ',num2str(s)],'fontsize',16) 
%     xlabel('Node','fontsize',16) 
%     ylabel('Node','fontsize',16)
%       
%     set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
% end
% 
% if datatype==0
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.45,0.4]);
% elseif datatype==1
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.55,0.6]);
% end
%         
% if datatype==0
%     saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'/group_connectvariance_estimation.fig'])
% elseif datatype==1
%     if session_n==1
%         saveas(gcf,['Hierarchical/real/LR/','group_connectvariance_estimation.fig'])
%     elseif session_n==2
%         saveas(gcf,['Hierarchical/real/RL/','group_connectvariance_estimation.fig'])
%     end
% end
% 
% % Visualize mean matrix (point estimate)
% figure
% 
% for s=1:N_state
%    if datatype==0  
%       subplot(2,3,s)
%    elseif datatype==1
%       subplot(3,4,s)
%    end 
%     imagesc(ave_adj{s})
%     colormap(turbo);
%     colorbar
%     title(['State',' ',num2str(s)],'fontsize',16) 
%     xlabel('Node','fontsize',16) 
%     ylabel('Node','fontsize',16)
%       
%     set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
% end
% 
% if datatype==0
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.45,0.4]);
% elseif datatype==1
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.55,0.6]);
% end
%         
% if datatype==0
%     saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'/group_ave_adj.fig'])
% elseif datatype==1
%     if session_n==1
%         saveas(gcf,['Hierarchical/real/LR/','group_ave_adj.fig'])
%     elseif session_n==2
%         saveas(gcf,['Hierarchical/real/RL/','group_ave_adj.fig'])
%     end
% end
% 
% % Visualize connectivity variance
% figure
% 
% for s=1:N_state
%    if datatype==0  
%       subplot(2,3,s)
%    elseif datatype==1
%       subplot(3,4,s)
%    end 
%     imagesc(variance_adj{s})
%     colormap(winter);
%     colorbar
%     title(['State',' ',num2str(s)],'fontsize',16) 
%     xlabel('Node','fontsize',16) 
%     ylabel('Node','fontsize',16)
%       
%     set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
% end
% 
% if datatype==0
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.45,0.4]);
% elseif datatype==1
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.55,0.6]);
% end
%         
% if datatype==0
%     saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'/group_variance_adj.fig'])
% elseif datatype==1
%     if session_n==1
%         saveas(gcf,['Hierarchical/real/LR/','group_variance_adj.fig'])
%     elseif session_n==2
%         saveas(gcf,['Hierarchical/real/RL/','group_variance_adj.fig'])
%     end
% end
%     
% figure
% for s=1:N_state
%     if datatype==0  
%        subplot(2,3,s)
%     elseif datatype==1
%        subplot(3,4,s)
%     end 
%     for i=1:35
%         for j=1:35
%             if i~=j
%                scatter(esti_connectmean{s}(i,j),ave_adj{s}(i,j),8,'filled')
%                hold on
%             end
%         end
%     end
%     if datatype==0
%        x=linspace(-0.1,1);
%        y=linspace(-0.1,1);
%        plot(x,y,'k--','linewidth', 1.2);
%     elseif datatype==1
%        x=linspace(-0.1,0.6);
%        y=linspace(-0.1,0.6);
%        plot(x,y,'k--','linewidth', 1.2);
%     end
%     hold on
%     set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
%     set(gca,'box','on')
%     title(['State ',num2str(s)],'fontsize',16) 
%     xlabel('Posterior sample','fontsize',16) 
%     ylabel('Data mean','fontsize',16)
% end
% 
% if datatype==0
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.42,0.4]);
% elseif datatype==1
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.55,0.6]);
% end
% 
% if datatype==0
%     saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'/comparison_mean.fig'])
% elseif datatype==1
%     if session_n==1
%         saveas(gcf,['Hierarchical/real/LR/','comparison_mean.fig'])
%     elseif session_n==2
%         saveas(gcf,['Hierarchical/real/RL/','comparison_mean.fig'])
%     end
% end
% 
% figure
% for s=1:N_state
%     if datatype==0  
%        subplot(2,3,s)
%     elseif datatype==1
%        subplot(3,4,s)
%     end 
%     for i=1:35
%         for j=1:35
%             if i~=j
%                scatter(esti_connectvariance{s}(i,j),variance_adj{s}(i,j),8,'filled')
%                hold on
%             end
%         end
%     end
%     if datatype==0
%        x=linspace(-0.01,0.1);
%        y=linspace(-0.01,0.1);
%        plot(x,y,'k--','linewidth', 1.2);
%     elseif datatype==1
%        x=linspace(-0.01,0.22);
%        y=linspace(-0.01,0.22);
%        plot(x,y,'k--','linewidth', 1.2);
%     end
%     hold on
%     
% 
%     set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
%     set(gca,'box','on')
%     title(['State ',num2str(s)],'fontsize',16) 
%     xlabel('Posterior sample','fontsize',16) 
%     ylabel('Data variance','fontsize',16)
% end
% 
% if datatype==0
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.45,0.4]);
% elseif datatype==1
%     set(gcf,'unit','normalized','position',[0.3,0.2,0.55,0.6]);
% end
% 
% if datatype==0
%     saveas(gcf,['Hierarchical/synthetic/','n',num2str(n_s),'/comparison_variance.fig'])
% elseif datatype==1
%     if session_n==1
%         saveas(gcf,['Hierarchical/real/LR/','comparison_variance.fig'])
%     elseif session_n==2
%         saveas(gcf,['Hierarchical/real/RL/','comparison_variance.fig'])
%     end
% end
% 
% 
% 
% 
% 
% 
% 
% 
%     