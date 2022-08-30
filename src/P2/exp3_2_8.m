clc
clear
close all
load("图像处理大作业\图像处理所需资源\JpegCoeff.mat");
load('图像处理大作业\图像处理所需资源\hall.mat');

[h,w] = size(hall_gray);

final = zeros(64,h*w/64); % 初始化

k = 1;

for i = 0:h/8-1
    for j = 0:w/8-1
        cur_mat = hall_gray(i*8+1:i*8+8,j*8+1:j*8+8);
        cur_mat = double(cur_mat)-128;
        dct_mat = dct2(cur_mat);
        quanti_mat = dct_mat./QTAB;
        final(:,k) = my_zigzag(quanti_mat);
        k = k+1;
    end
end

