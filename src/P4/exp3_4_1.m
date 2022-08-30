close all; clear; clc;

for L = 3:5
I = 28;
delta = 2^(8-L);
% 得到标尺
ruler = 0:2^L-1;
ruler = ruler*delta;
v = zeros(1,2^(3*L));
for cnt = 1:I
    name = ['../../图像处理所需资源/Faces/',num2str(cnt),'.bmp'];
    pic = imread(name);
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
    v = v+u;
end
v = v./I;
subplot(3,1,L-2);
plot(v);
title("L = "+L);
end
