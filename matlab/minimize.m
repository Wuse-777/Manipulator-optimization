clc;
clear;
tic;

%��֤�ɸ�����
rng default;


% rng('shuffle');

%�Ż�6�γ���fitness������ͬ���޸�
Aeq=[1 1 1 0 1 0];
beq=1008;
A=[];b=[];
lb=[100 200 200 80 80 80];
ub=[140 600 600 120 120 120];
nonlcon=[];

fun=@fitness;

options = optimoptions('ga','PlotFcn', {@gaplotbestf,@savefun}, ...
    'MaxGenerations',30,'PopulationSize',20,'UseParallel',true,...
    'InitialPopulationMatrix',[121.5,408,376,102.5,102.5,94]);
[x,fval,exitflag,output,population,scores] = ga(fun,6,A,b,Aeq,beq,lb,ub,nonlcon,options);


%�Ż�2�γ�
% Aeq=[1 1];
% beq=784;
% A=[];b=[];
% lb=[20 20];
% ub=[1000 1000];
% nonlcon=[];
% 
% fun=@fitness;
% 
% options = optimoptions('ga','PlotFcn', {@gaplotbestf},'InitialPopulationMatrix', ...
%     [408 376],'MaxGenerations',20,'PopulationSize',20,'UseParallel',true);
% [x,fval,exitflag,output,population,scores] = ga(fun,2,A,b,Aeq,beq,lb,ub,nonlcon,options);



toc;