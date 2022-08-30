clc
clear
close all
load("图像处理大作业\图像处理所需资源\JpegCoeff.mat");
load('图像处理大作业\图像处理所需资源\hall.mat');
load('图像处理大作业\图像处理所需资源\snow.mat');

figure(1)
imshow(snow);
[H,W] = size(snow);
[Dc,Ac] = my_jpeg_encode(snow,QTAB,DCTAB,ACTAB);
new_snow = my_jpeg_decode(Dc,Ac,DCTAB,ACTAB,QTAB,H,W);
figure(2)
imshow(new_snow);

fprintf("snow: Compress_Ratio = %f , PSNR = %f\n",my_Ratio(snow,Ac,Dc),my_PSNR(snow,new_snow));