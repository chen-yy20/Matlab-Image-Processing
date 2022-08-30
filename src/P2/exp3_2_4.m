close all, clear all; clc;
% load("图像处理大作业\图像处理所需资源\JpegCoeff.mat");
load('图像处理大作业\图像处理所需资源\hall.mat');
small_hall_gray = hall_gray(64:71,64:71);
figure('Name','原图');
imshow(small_hall_gray);

small_hall_gray = double(small_hall_gray);
ori_hall_gray = small_hall_gray-128;
ori_dct = dct2(ori_hall_gray);
ori_dct_T = ori_dct';
ori_dct_90 = rot90(ori_dct);
ori_dct_180 = rot90(ori_dct_90);


new_hall_gray1 = idct2(ori_dct_T)+128;
new_hall_gray1 = uint8(new_hall_gray1);

new_hall_gray2 = idct2(ori_dct_90)+128;
new_hall_gray2 = uint8(new_hall_gray2);

new_hall_gray3 = idct2(ori_dct_180)+128;
new_hall_gray3 = uint8(new_hall_gray3);

figure('Name','转置')
imshow(new_hall_gray1);
figure('Name','rot90')
imshow(new_hall_gray2);
figure('Name','rot180')
imshow(new_hall_gray3);