clear
clc
z=[3 2 1 1 2 3 3 3 2 2 1 3 1 2 2 2 1 3 3 3 3]';
Mean=[0.22 0.05 -0.06;...
      0.05 0.30 0.02;...
      -0.06 0.02 0.18];
Vari=[0.1 0.02 0.01;...
      0.02 0.15 0.03;...
      0.01 0.03 0.09];
% Mean=[0.05 0.05 0.05;...
%       0.05 0.05 0.05;...
%       0.05 0.05 0.05];
% Vari=[0.01 0.01 0.01;...
%       0.01 0.01 0.01;...
%       0.01 0.01 0.01];
x=adja_generator(z,Mean,Vari);

% save the Test results
Test_path = fileparts(mfilename('fullpath'));
if isempty(Test_path), Test_path = pwd; end
Test_path=fullfile(Test_path,'Test','test');
save(Test_path);

 