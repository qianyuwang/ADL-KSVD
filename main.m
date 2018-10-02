clear all;
clc;
warning off;

addpath(genpath('.\ksvdbox'));
addpath(genpath('.\OMPbox'));
load('.\trainingdata\featurevectors.mat');
%% feature normalization
test_feats=normcols(testing_feats);
train_feats=normcols(training_feats);

%% parameter setup
Magni_H=5;
init.X=[];
init.Om=[];
init.W=[];
result.ta=[];
result.X=[];
result.Om=[];
result.W=[];
iterations=5;
itecircles=5;
delta=1e-6;
par.sparsitythres=[30];
par.alpha=[8];
par.beta=[3e-2];

%% training and testing
for i=1:size(par.sparsitythres,2)
    sparsitythres=par.sparsitythres(i);
    for j=1:size(par.alpha,2)
        alpha=par.alpha(j);
        for k=1:size(par.beta,2)
            beta=par.beta(k);
            fprintf('sparsity=%d,alpha=%f\n',sparsitythres,alpha);
            
            %initialization
            fprintf('\nADL-KSVD Initializing ... ...');
            tic
            [Htr_Extend]=extend_H( H_train,Magni_H ); %initialize H
            [Xinit,Ominit,Winit]=INIT(train_feats,H_train,Htr_Extend,alpha,delta,beta); % initialize X, Omega and W
            time4init=toc; % record time
            init.X=[init.X;Xinit];
            init.Om=[init.Om;Ominit];
            init.W=[init.W;Winit];
            fprintf('Time for initialization is: %.03f seconds.\n',time4init);
            
            %training
            fprintf('\nADL-KSVD Training ... ...');
            tic
            [X,Om,W]=TRAIN(train_feats,H_train,Xinit,Ominit,Winit,alpha,beta,iterations,itecircles,sparsitythres); %training
            time4train=toc;
            fprintf('Time for training is: %.03f seconds.\n',time4train);
            
            %classification
            fprintf('\nADL-KSVD CLASSIFICATION ... ...');
            tic
            [~,accuracy]=CLASS(test_feats,H_test,Om,W,sparsitythres); %testing
            time4class=toc;
            fprintf('Time for classification is: %.03f seconds.\n',time4class);
            fprintf('Accuracy for classification is: %.02f%%.\n',accuracy*100);
        end
    end
end
fprintf('\nFinished!\n');
