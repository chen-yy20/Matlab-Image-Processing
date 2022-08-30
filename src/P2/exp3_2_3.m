close all, clear all; clc;
% load("图像处理大作业\图像处理所需资源\JpegCoeff.mat");
load('图像处理大作业\图像处理所需资源\hall.mat');
small_hall_gray = hall_gray(20:100,20:100);
figure('Name','原图');
imshow(small_hall_gray);

small_hall_gray = double(small_hall_gray);
ori_hall_gray = small_hall_gray-128;
ori_dct = dct2(ori_hall_gray);
ori_dct_lft = ori_dct;
ori_dct_rgt = ori_dct;
ori_dct_lft(:,1:4) = zeros(81,4);
ori_dct_rgt(:,78:81) = zeros(81,4);

new_hall_gray1 = idct2(ori_dct_lft)+128;
new_hall_gray1 = uint8(new_hall_gray1);

new_hall_gray2 = idct2(ori_dct_rgt)+128;
new_hall_gray2 = uint8(new_hall_gray2);
figure('Name','左置零')
imshow(new_hall_gray1);
figure('Name','右置零')
imshow(new_hall_gray2);
 