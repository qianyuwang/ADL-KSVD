function [H_Extend]  = extend_H( H_ori,Magni_H )
% FUNCTION EXTEND_H extend the row of H to Magni_H*original_row_H

H_Extend=[]; 
k=0;
for j=1:1:size(H_ori,1)
        for i=1:1:Magni_H
           H_Extend(i+k*Magni_H,:)=H_ori(j,:);
        end
        k=k+1;
 end
 