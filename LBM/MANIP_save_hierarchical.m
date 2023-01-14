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
cd 'Hierarchical/synthetic/n0.3162_hrf';
open('assign_prob_max_state_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_max_state_1.svg'])
close all

open('assign_prob_max_state_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_max_state_2.svg'])
close all

open('assign_prob_max_state_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_max_state_3.svg'])
close all

open('assign_prob_max_state_4.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_max_state_4.svg'])
close all

open('assign_prob_max_state_5.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_max_state_5.svg'])
close all

open('assign_prob_state_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_state_1.svg'])
close all

open('assign_prob_state_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_state_2.svg'])
close all

open('assign_prob_state_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_state_3.svg'])
close all

open('assign_prob_state_4.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_state_4.svg'])
close all

open('assign_prob_state_5.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/assign_prob_state_5.svg'])
close all


open('comparison_mean_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_mean_1.svg'])
close all

open('comparison_mean_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_mean_2.svg'])
close all

open('comparison_mean_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_mean_3.svg'])
close all

open('comparison_mean_4.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_mean_4.svg'])
close all

open('comparison_mean_5.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_mean_5.svg'])
close all

open('comparison_variance_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_variance_1.svg'])
close all

open('comparison_variance_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_variance_2.svg'])
close all

open('comparison_variance_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_variance_3.svg'])
close all

open('comparison_variance_4.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_variance_4.svg'])
close all

open('comparison_variance_5.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/comparison_variance_5.svg'])
close all


open('group_ave_adj.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_ave_adj.svg'])
close all

open('group_connectmean_estimation.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_connectmean_estimation.svg'])
close all

open('group_connectvariance_estimation.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_connectvariance_estimation.svg'])
close all

open('group_latent_labels_1.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_latent_labels_1.svg'])
close all

open('group_latent_labels_2.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_latent_labels_2.svg'])
close all

open('group_latent_labels_3.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_latent_labels_3.svg'])
close all

open('group_latent_labels_4.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_latent_labels_4.svg'])
close all

open('group_latent_labels_5.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_latent_labels_5.svg'])
close all

open('group_variance_adj.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/group_variance_adj.svg'])
close all

open('Labels_esti.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/Labels_esti.svg'])
close all

open('Labels_switched.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/Labels_switched.svg'])
close all

open('Labels_true.fig')
saveas(gcf,['../../../',pic_path,'n0.3162_hrf/Labels_true.svg'])
close all





