function [X,Om,W]=TRAIN(Y,H,Xinit,Ominit,Winit,alpha1,alpha3,iterations,itecircles,sparsitythres)
a1=sqrt(alpha1);
n=size(Xinit,1);
E=eye(n);
Omt=Ominit;
Wt=Winit;
params.Tdata = sparsitythres;
params.iternum = iterations;
params.memusage = 'high';
D_ext2 = [E;a1.*Wt];
D_ext2=normcols(D_ext2);
for i=1:itecircles
    %fprintf('\niteration=%d\n',i)
    params.data = [Omt*Y;a1.*H];
    params.initdict = D_ext2;
    [IW,Xt,err] = ksvd(params,'');
    Omt=Xt*Y'/(Y*Y'+alpha3.*eye(size(Y*Y')));
    D_ext2=IW;
end
Wt= IW(size(E,1)+1:size(IW,1),:);
Wt=Wt./a1;
W=Wt;
X=Xt;
Om=Omt;

