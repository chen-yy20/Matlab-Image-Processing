close all;
clear;
clc;
load("../../图像处理所需资源/hall.mat");
load("../../图像处理所需资源/JpegCoeff.mat");
load("jpegcode.mat");

for i = 1:5
    disp("次数："+i);
    message = int2str(randi([0,1],1,H*W));
    message(message==' ') = []; %消去空格
    
    y = in_mat1(hall_gray,message);
    % 未进行编解码
    out1 = ex_mat1(y,length(message));
    ori = double(message)-48;
    new = double(out1) - 48;
    l = length(ori);
    right = sum(~xor(new,ori));
    disp("BMP正确率："+right/l+" ");

    [cd,ac] = my_jpeg_encode(y,QTAB,DCTAB,ACTAB);
    out_mat = my_jpeg_decode(cd,ac,DCTAB,ACTAB,QTAB,H,W);
    
    out = ex_mat1(out_mat,length(message));
    
    ori = double(message)-48;
    new = double(out) - 48;
    l = length(ori);
    right = sum(~xor(new,ori));
    disp("JPEG正确率："+right/l+" ");
end