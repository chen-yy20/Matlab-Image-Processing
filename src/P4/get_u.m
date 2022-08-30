function u = get_u(pic,L)
 
delta = 2^(8-L);
% 得到标尺
ruler = 0:2^L-1;
ruler = ruler*delta;
% imshow(pic);
[H,W,~] = size(pic);
u = zeros(1,2^(3*L));
total = H*W;
% 首先需要将RGB变成n的格式
for i = 1:H
    for j = 1:W
        R = double(pic(i,j,1));
        G = double(pic(i,j,2));
        B = double(pic(i,j,3));
        temp = abs(ruler - R);
        [~,Ri] = min(temp);
        temp = abs(ruler - G);
        [~,Gi] = min(temp);
        temp = abs(ruler - B);
        [~,Bi] = min(temp);
        idx = (Ri-1)*(2^(2*L))+(Gi-1)*(2^L)+Bi;
        u(idx) = u(idx)+1/total;
    end
end
%plot(u);

end