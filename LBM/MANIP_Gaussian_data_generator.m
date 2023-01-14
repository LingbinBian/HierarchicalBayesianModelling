% Gaussian time series generator
%
% Version 1.0 
% Copyright (c) 2019, Lingbin Bian
% 09-Aug-2019
%--------------------------------------------------------------------------
clear
clc
close all
%--------------------------------------------------------------------------
% simulated time series
T=180; % time course
N=35; % the number of nodes
K_seg=[3 4 5 3 5 4 3]; % the number of communities for data segments
%n_s=0.3162;  % 10dB
n_s=0.5623;  % 5dB
%n_s=1;  % 0dB
%n_s=1.7783;  % -5dB
%n_s=3.1623;  % -10dB
ind=1;  % 1: vari and hrf, 2: only SNR
changepoints=[20 50 80 100 130 160];
vari=0;  % degree of variation of community structure
hrf_ind=1;  % 1: apply a hrf, 0: do not apply a hrf

if ind==0
   generateSignal(T,N,changepoints,K_seg,n_s);
else
   generateSignal_subjvari_hrf(T,N,changepoints,K_seg,n_s,vari,hrf_ind);    
end

