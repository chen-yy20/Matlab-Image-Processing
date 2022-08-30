close all,clear all;clc;
load('图像处理大作业\图像处理所需资源\hall.mat');
hall_color2 = hall_color;
% imshow(hall_color);
si = size(hall_color);
si = si(1:2);  % 宽与长
r = round(min(si)/2);
r2 = r^2;
centre = si./2; % 中心
for i = 1:si(1)
    for j = 1:si(2)
        dis = (i-centre(1))^2+(j-centre(2))^2;
        if abs(dis-r2)<= 50
            hall_color(i,j,:) = [255,0,0];
        end
    end
end
figure(1);
imshow(hall_color);

% 棋盘
for i = 1:si(1)
    for j = 1:si(2)
        if mod((i+j),2) ~= 0
            hall_color2(i,j,:) = [0,0,0];
        end
    end
end
figure(2);
imshow(hall_color2);
