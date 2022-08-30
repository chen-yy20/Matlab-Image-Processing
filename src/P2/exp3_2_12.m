clc
clear
close all
load("图像处理大作业\图像处理所需资源\JpegCoeff.mat");
load('图像处理大作业\图像处理所需资源\hall.mat');

[H,W] = size(hall_gray);
[Dc1,Ac1] = my_jpeg_encode(hall_gray,QTAB,DCTAB,ACTAB);
whole_mat1 = my_jpeg_decode(Dc1,Ac1,DCTAB,ACTAB,QTAB,H,W);
fprintf("origin: Compress_Ratio = %f , PSNR = %f\n",my_Ratio(hall_gray,Ac1,Dc1),my_PSNR(hall_gray,whole_mat1));


QTAB = QTAB/2;
[Dc2,Ac2] = my_jpeg_encode(hall_gray,QTAB,DCTAB,ACTAB);
whole_mat2 = my_jpeg_decode(Dc2,Ac2,DCTAB,ACTAB,QTAB,H,W);
fprintf("new: Compress_Ratio = %f , PSNR = %f\n",my_Ratio(hall_gray,Ac2,Dc2),my_PSNR(hall_gray,whole_mat2));