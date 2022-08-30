close all
clear
clc

load("../../图像处理所需资源/hall.mat");
load("jpegcode.mat");

ratio = my_Ratio(hall_gray,final_Ac,final_Cd);
disp("Compress_ratio = "+ratio);

