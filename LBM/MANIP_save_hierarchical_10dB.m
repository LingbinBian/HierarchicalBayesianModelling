% This script saves all the figures in a single destination file

% Version 1.0
% 21-March-2021
% Copyright (c) 2021, Lingbin Bian

clear
clc
close all

% destination file

pic_path='../pictures_Hierarchical/synthetic/';
  
% save hierarchical synthetic
cd 'Results/synthetic/n0.3162';
open('assign_prob_max_state_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/assign_prob_max_state_1.svg'])
close all

open('assign_prob_max_state_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/assign_prob_max_state_2.svg'])
close all

open('assign_prob_max_state_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/assign_prob_max_state_3.svg'])
close all



open('assign_prob_state_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/assign_prob_state_1.svg'])
close all

open('assign_prob_state_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/assign_prob_state_2.svg'])
close all

open('assign_prob_state_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/assign_prob_state_3.svg'])
close all


open('group_ave_adj.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/group_ave_adj.svg'])
close all

open('group_connectmean_estimation.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/group_connectmean_estimation.svg'])
close all

open('group_connectvariance_estimation.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/group_connectvariance_estimation.svg'])
close all

open('group_latent_labels_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/group_latent_labels_1.svg'])
close all

open('group_latent_labels_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/group_latent_labels_2.svg'])
close all

open('group_latent_labels_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/group_latent_labels_3.svg'])
close all


open('group_variance_adj.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/group_variance_adj.svg'])
close all


open('Labels_esti_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_esti_1.svg'])
close all

open('Labels_esti_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_esti_2.svg'])
close all

open('Labels_esti_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_esti_3.svg'])
close all

open('Labels_switched_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_switched_1.svg'])
close all

open('Labels_switched_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_switched_2.svg'])
close all

open('Labels_switched_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_switched_3.svg'])
close all

open('Labels_true_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_true_1.svg'])
close all


open('Labels_true_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_true_2.svg'])
close all

open('Labels_true_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/Labels_true_3.svg'])
close all

open('comparison_mean_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/comparison_mean_1.svg'])
close all

open('comparison_mean_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/comparison_mean_2.svg'])
close all

open('comparison_mean_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/comparison_mean_3.svg'])
close all



open('comparison_variance_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/comparison_variance_1.svg'])
close all

open('comparison_variance_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/comparison_variance_2.svg'])
close all

open('comparison_variance_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162/comparison_variance_3.svg'])
close all

