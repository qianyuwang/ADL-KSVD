function matout=normcols(matin)
% 功能：输入矩阵的列归一化
% 输入：
%       matin       -输入一个矩阵
% 输出：
%       matout      -输出矩阵(每列的二范数值为1)


l2norms = sqrt(sum(matin.*matin,1)+eps);
matout = matin./repmat(l2norms,size(matin,1),1);