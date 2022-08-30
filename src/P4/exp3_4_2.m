close all; clear; clc;
pic = imread('../../图像处理所需资源/Faces/最强合影.png');
% imshow(pic);

acc = 0.3; % 扫描精度：一般取0.2-1,最高为1.2 
L = 5;
name = ['v',num2str(L),'.mat'];
load(name);
new_pic = find_face(pic,v,L,acc);

imshow(new_pic);
