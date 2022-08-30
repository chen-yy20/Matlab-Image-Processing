close all; clear; clc;
pic = imread('../../图像处理所需资源/Faces/最强合影.png');
acc = 0.2; % 扫描精度：一般取0.2-1,最高为1.2 
L = 5;
name = ['v',num2str(L),'.mat'];
load(name);


% I = imrotate(pic,90);
% new_pic1 = find_face(I,v,L,acc);
% imshow(new_pic1);

% [H,W,~] = size(pic);
% J = imresize(pic,[H,2*W]);
% new_pic2 = find_face(J,v,L,acc);
% imshow(new_pic2);


K = imadjust(pic,[.2 .3 0; .6 .7 1],[]);
new_pic3 = find_face(K,v,L,acc);
imshow(new_pic3);