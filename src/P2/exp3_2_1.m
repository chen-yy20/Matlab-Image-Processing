close all, clear all; clc;
load("图像处理大作业\图像处理所需资源\JpegCoeff.mat");
load('图像处理大作业\图像处理所需资源\hall.mat');
small_hall_gray = hall_gray(1:8,1:8);
small_hall_gray = double(small_hall_gray);
ori_hall_gray = small_hall_gray-128;
ori_dct = dct2(ori_hall_gray);
new_dct = dct2(small_hall_gray);
a = ones(8).*128;
offset = dct2(a);
new_dct(1,1) = new_dct(1,1)-offset(1,1);
dis = sum(abs(new_dct-ori_dct),'all');
disp(['变换后误差dis = ',num2str(dis)]);

% imshow(log(dis),[])
% colormap parula
% colorbar
