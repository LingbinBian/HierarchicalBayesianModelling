% Inference of real data for all of the subjects.
%
%
% Version 1.0 
% Copyright (c) 2020, Lingbin Bian
% 20-Feb-2020

% -------------------------------------------------------------------------
% load data
data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
subjects=load('subject.txt');
% -------------------------------------------------------------------------
K_seg=3; % number of communities
W=11;   % half of window size
S=50;   % repetition number
session_n=1;
thres=1;


for i=1:100
    subid=num2str(subjects(i));
    fprintf('subject ID = %s\n',subid);
    infer_real(subid,session_n,K_seg,W,S,thres);   % 1: session LR, 2: session RL
  %  infer_real(subid,2,K_seg,W,S); 
end

