function [prediction,accuracy]=CLASS(Y,H,Om,W,sparsitythres)
err=0;
prediction = [];
get_hs=[];
for id=1:size(Y,2);
    get_y=Y(:,id);
    get_x=Om*get_y;
    sor=sort(get_x);
    compare=sor(end-sparsitythres+1);
    for t=1:size(get_x,1);
        if get_x(t)<compare;
            get_x(t)=0;
        end
    end
    get_h=W*get_x;
    get_hs=[get_hs,get_h];
    right_h=H(:,id);
    [numc,placec]=max(get_h);
    [numr,placer]=max(right_h);
    if(placec~=placer)
        err=err+1;
    end
end
accuracy = (size(Y,2)-err)/size(Y,2);

