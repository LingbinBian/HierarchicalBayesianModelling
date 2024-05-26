% MANIP Jaccard similarity between estimation and truth

clear
clc
close all

n_s=1;  % 0.3162: SNR=10dB, 0.5623: SNR=5dB, 1: SNR=0;

load(['Results/synthetic/n',num2str(n_s),'/grouplevel_results.mat']);

J_1=jaccardsimi(label_compare{1,1}(:,1),label_compare{1,1}(:,2))

J_2=jaccardsimi(label_compare{1,2}(:,1),label_compare{1,2}(:,2))

J_3=jaccardsimi(label_compare{1,3}(:,1),label_compare{1,3}(:,2))