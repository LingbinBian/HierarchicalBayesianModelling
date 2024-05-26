% Hierarchical Bayesian modelling
% Modelling connectivity
%
% Version 1.0
% 10-March-2021
% Copyright (c) 2021, Lingbin Bian

clear
clc
close all

N=100;
datatype=0;

if datatype==0
    % n_s=0.3162;
    % n_s=0.5623;
     n_s=1;
    load(['Results/synthetic/n',num2str(n_s),'/grouplevel_data.mat']);
    localmin_t=state_t;
    L_localmin=N_state;
elseif datatype==1
    session_n=1;
    if session_n==1
        load('Results/real/LR/grouplevel_data.mat');    
    elseif session_n==2
        load('Results/real/RL/grouplevel_data.mat'); 
    end
end

% Modelling connectivity
[esti_connectmean,esti_connectvariance]=connectivity_modelling(group_adj,N,localmin_t,100);

% point estimate
ave_adj=cell(1,L_localmin);  % averaged adjacency matrix
variance_adj=cell(1,L_localmin);  % variance matrix

adj_mean=zeros(N_subj,1);
for t=1:L_localmin
    for i=1:N
        for j=1:N
            for s=1:N_subj
                adj_mean(s,1)=group_adj{s,1}{1,t}(i,j);
            end
            ave_adj{1,t}(i,j)=mean(adj_mean);
        end
    end
end

adj_vari=zeros(N_subj,1);
for t=1:L_localmin
    for i=1:N
        for j=1:N
            for s=1:N_subj
                adj_vari(s,1)=group_adj{s,1}{1,t}(i,j);
            end
            variance_adj{1,t}(i,j)=var(adj_vari);
        end
    end
end


% Visualize connectivity mean ---------------------------------------------
figure

for s=1:N_state
   if datatype==0  
      subplot(1,3,s)
   elseif datatype==1
      subplot(3,4,s)
   end 
    imagesc(esti_connectmean{s})
    colormap(turbo);
    colorbar
    title(['State',' ',num2str(s)],'fontsize',16) 
    xlabel('Node','fontsize',16) 
    ylabel('Node','fontsize',16)
      
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
end

if datatype==0
    set(gcf,'unit','normalized','position',[0.3,0.2,0.5,0.18]);
elseif datatype==1
    set(gcf,'unit','normalized','position',[0.3,0.2,0.7,0.6]);
end
data_path = fileparts(mfilename('fullpath'));       
if datatype==0
    saveas(gcf,['Results/synthetic/','n',num2str(n_s),'/group_connectmean_estimation.fig'])
elseif datatype==1
    if session_n==1
        L_results_path=fullfile(data_path,'Results/real/LR/LR_meanconnectivity');
        save(L_results_path,'esti_connectmean','ave_adj');
        saveas(gcf,['Results/real/LR/','group_connectmean_estimation.fig'])
    elseif session_n==2
        R_results_path=fullfile(data_path,'Results/real/RL/RL_meanconnectivity');
        save(R_results_path,'esti_connectmean','ave_adj');
        saveas(gcf,['Results/real/RL/','group_connectmean_estimation.fig'])
    end
end

% Visualize connectivity variance -----------------------------------------
figure

for s=1:N_state
   if datatype==0  
      subplot(1,3,s)
   elseif datatype==1
      subplot(3,4,s)
   end 
    imagesc(esti_connectvariance{s})
    colormap(winter);
    colorbar
    title(['State',' ',num2str(s)],'fontsize',16) 
    xlabel('Node','fontsize',16) 
    ylabel('Node','fontsize',16)
      
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
end

if datatype==0
    set(gcf,'unit','normalized','position',[0.3,0.2,0.5,0.18]);
elseif datatype==1
    set(gcf,'unit','normalized','position',[0.3,0.2,0.7,0.6]);
end
        
if datatype==0
    saveas(gcf,['Results/synthetic/','n',num2str(n_s),'/group_connectvariance_estimation.fig'])
elseif datatype==1
    if session_n==1
        saveas(gcf,['Results/real/LR/','group_connectvariance_estimation.fig'])
    elseif session_n==2
        saveas(gcf,['Results/real/RL/','group_connectvariance_estimation.fig'])
    end
end

% Visualize mean matrix (point estimate)-----------------------------------
figure

for s=1:N_state
   if datatype==0  
      subplot(1,3,s)
   elseif datatype==1
      subplot(3,4,s)
   end 
    imagesc(ave_adj{s})
    colormap(turbo);
    colorbar
    title(['State',' ',num2str(s)],'fontsize',16) 
    xlabel('Node','fontsize',16) 
    ylabel('Node','fontsize',16)
      
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
end

if datatype==0
    set(gcf,'unit','normalized','position',[0.3,0.2,0.5,0.18]);
elseif datatype==1
    set(gcf,'unit','normalized','position',[0.3,0.2,0.7,0.6]);
end
        
if datatype==0
    saveas(gcf,['Results/synthetic/','n',num2str(n_s),'/group_ave_adj.fig'])
elseif datatype==1
    if session_n==1
        saveas(gcf,['Results/real/LR/','group_ave_adj.fig'])
    elseif session_n==2
        saveas(gcf,['Results/real/RL/','group_ave_adj.fig'])
    end
end

% Visualize variance matrix (point estimate) ------------------------------
figure

for s=1:N_state
   if datatype==0  
      subplot(1,3,s)
   elseif datatype==1
      subplot(3,4,s)
   end 
    imagesc(variance_adj{s})
    colormap(winter);
    colorbar
    title(['State',' ',num2str(s)],'fontsize',16) 
    xlabel('Node','fontsize',16) 
    ylabel('Node','fontsize',16)
      
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
end

if datatype==0
    set(gcf,'unit','normalized','position',[0.3,0.2,0.5,0.18]);
elseif datatype==1
    set(gcf,'unit','normalized','position',[0.3,0.2,0.7,0.6]);
end
        
if datatype==0
    saveas(gcf,['Results/synthetic/','n',num2str(n_s),'/group_variance_adj.fig'])
elseif datatype==1
    if session_n==1
        saveas(gcf,['Results/real/LR/','group_variance_adj.fig'])
    elseif session_n==2
        saveas(gcf,['Results/real/RL/','group_variance_adj.fig'])
    end
end
    
% -------------------------------------------------------------------------
% % comparison
connect_mean_row=zeros(N_state,N*N-N);
ave_adj_row=zeros(N_state,N*N-N);
R_mean=zeros(N_state,1);

for s=1:N_state
    count=0;
    figure
    for i=1:N
        for j=1:N
            if i~=j
               scatter(esti_connectmean{s}(i,j),ave_adj{s}(i,j),8,'filled')
               hold on
               connect_mean_row(s,count+1)=esti_connectmean{s}(i,j);
               ave_adj_row(s,count+1)=ave_adj{s}(i,j);
               count=count+1;

            end
        end
    end
    count=0;
    R_m=corrcoef(connect_mean_row(s,:),ave_adj_row(s,:));
    R_mean(s,1)=R_m(1,2);

    if datatype==0
       x=linspace(-0.1,1);
       y=linspace(-0.1,1);
       plot(x,y,'k--','linewidth', 1.2);
    elseif datatype==1
       x=linspace(-0.1,0.6);
       y=linspace(-0.1,0.6);
       plot(x,y,'k--','linewidth', 1.2);
    end
    hold on
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
    set(gca,'box','on')
    
    title(['State ',num2str(s)],'fontsize',16) 
    xlabel('Posterior sample','fontsize',16) 
    ylabel('Data mean','fontsize',16)


if datatype==0
    set(gcf,'unit','normalized','position',[0.3,0.22,0.115,0.185]);
elseif datatype==1
    set(gcf,'unit','normalized','position',[0.3,0.22,0.115,0.185]);
end

if datatype==0
    saveas(gcf,['Results/synthetic/','n',num2str(n_s),'/comparison_mean_',num2str(s),'.fig'])
elseif datatype==1
    if session_n==1
        saveas(gcf,['Results/real/LR/','comparison_mean.fig'])
    elseif session_n==2
        saveas(gcf,['Results/real/RL/','comparison_mean.fig'])
    end
end
end


connect_variance_row=zeros(N_state,N*N-N);
variance_adj_row=zeros(N_state,N*N-N);
R_variance=zeros(N_state,1);

for s=1:N_state
    count=0;
    figure
    for i=1:N
        for j=1:N
            if i~=j
               scatter(esti_connectvariance{s}(i,j),variance_adj{s}(i,j),8,'filled')
               hold on
               connect_variance_row(s,count+1)=esti_connectvariance{s}(i,j);
               variance_adj_row(s,count+1)=variance_adj{s}(i,j);
               count=count+1;
            end
        end
    end
    count=0;
    R_v=corrcoef(connect_variance_row(s,:),variance_adj_row(s,:));
    R_variance(s,1)=R_v(1,2);

    if datatype==0
       x=linspace(-0.01,0.1);
       y=linspace(-0.01,0.1);
       plot(x,y,'k--','linewidth', 1.2);
    elseif datatype==1
       x=linspace(-0.01,0.22);
       y=linspace(-0.01,0.22);
       plot(x,y,'k--','linewidth', 1.2);
    end
    hold on
    

    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
    set(gca,'box','on')
    title(['State ',num2str(s)],'fontsize',16) 
    xlabel('Posterior sample','fontsize',16) 
    ylabel('Data variance','fontsize',16)


if datatype==0
    set(gcf,'unit','normalized','position',[0.3,0.22,0.115,0.185]);
elseif datatype==1
    set(gcf,'unit','normalized','position',[0.3,0.22,0.115,0.185]);
end

if datatype==0
    saveas(gcf,['Results/synthetic/','n',num2str(n_s),'/comparison_variance_',num2str(s),'.fig'])
elseif datatype==1
    if session_n==1
        saveas(gcf,['Results/real/LR/','comparison_variance.fig'])
    elseif session_n==2
        saveas(gcf,['Results/real/RL/','comparison_variance.fig'])
    end
end
end


data_path = fileparts(mfilename('fullpath'));
if datatype==0
   R_results_path=fullfile(data_path,['Results/synthetic/','n',num2str(n_s),'/R_results']);
   save(R_results_path,'R_mean','R_variance');
end








