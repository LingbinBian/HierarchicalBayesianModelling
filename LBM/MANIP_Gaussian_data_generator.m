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
T=300; % time course
N=100; % the number of nodes
K_seg=[8 9 10]; % the number of communities for data segments
%n_s=0.3162;  % 10dB
%n_s=0.5623;  % 5dB
n_s=1;  % 0dB
%n_s=1.7783;  % -5dB
%n_s=3.1623;  % -10dB
ind=0;  % 1: vari and hrf, 0: only SNR
changepoints=[100 200];
vari=0;  % degree of variation of community structure
hrf_ind=0;  % 1: apply a hrf, 0: do not apply a hrf

if ind==0
   generateSignal(T,N,changepoints,K_seg,n_s);
else
   generateSignal_subjvari_hrf(T,N,changepoints,K_seg,n_s,vari,hrf_ind);    
end

 