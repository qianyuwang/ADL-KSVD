function [Xinit,Ominit,Winit]=INIT(training_feats,H_train,H_tend,alpha1,alpha2,alpha3)
Y=training_feats;
Xinit=H_tend;
Winit=alpha1.*H_train*Xinit'/(alpha1.*Xinit*Xinit'+alpha2.*eye(size(Xinit*Xinit')));
Ominit=Xinit*Y'/(Y*Y'+alpha3.*eye(size(Y*Y')));
