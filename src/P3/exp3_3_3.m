close all;
clear;
clc;
load("../../图像处理所需资源/hall.mat");
load("../../图像处理所需资源/JpegCoeff.mat");

[H,W] = size(hall_gray);
final = zeros(64,H*W/64); % 初始化
k = 1;
message = int2str(randi([0,1],1,H*W/64*9));
% 选择每个图像块左上角的9个DCT系数
message(message==' ') = []; %消去空格
% disp(message);
len = length(message);
inmat = 1;
changeinmat = 0;
for i = 0:H/8-1
    for j = 0:W/8-1
      
        cur_mat = hall_gray(i*8+1:i*8+8,j*8+1:j*8+8);
        cur_mat = double(cur_mat)-128;
        dct_mat = dct2(cur_mat);
        quanti_mat = round(dct_mat./QTAB);
        %------------ 插入信息-----------------------
        t = W/8;
        if inmat ==1
            if (k-1)*9+9>len
                this_message = message((k-1)*9+1:end);
                changeinmat = 1; 
            else
                this_message = message((k-1)*9+1:(k-1)*9+9);
            end
            
            nquanti_mat = in_mat3(quanti_mat,this_message);
        else
            nquanti_mat = quanti_mat;
        end
        if changeinmat == 1
            inmat = 0;
        end
        %--------------------------------------------
        % disp(this_message);
        final(:,k) = my_zigzag(nquanti_mat);
        k = k+1;
    end
end

% 直流分量矢量
Cd = final(1,:);
[a,w] = size(Cd);
di_Cd = zeros(1,w); % 差分矢量
for i = 1:w
    if i == 1
        di_Cd(i) = Cd(i);
    else 
        di_Cd(i) = Cd(i-1)-Cd(i);
    end
end
final_Cd = [];
for i = 1:w
    x = di_Cd(i);
    cat = dif2cat(x);
    num = DCTAB(cat+1,1);
    temp_arr = DCTAB(cat+1,2:1+num);
    final_Cd = [final_Cd, temp_arr, my_dec2bin(x)];
end

% 交流分量矢量
Ac = final(2:end,:);
ZRL = [1,1,1,1,1,1,1,1,0,0,1];
EOB = [1,0,1,0];
[h,w] = size(Ac);
final_Ac = [];

for time = 1:w
    flag = 0;
    current = Ac(:,time);
    for i = 1:h
        if flag == 0
            run = 0;
        end

        if current(i) == 0
            run = run +1;
            flag = 1;
        else
            % 不是0时 开始整理数字
            while run >= 16
               final_Ac = [final_Ac,ZRL];
               run = run - 16;
            end
            mag = my_dec2bin(current(i));
            [~,si] = size(mag);
            final_Ac = [final_Ac,acnum(run,si,ACTAB),mag];
            flag = 0;
        end

        if i == h
             final_Ac = [final_Ac,EOB];
        end
    
    end
end

[out_mat,out_message] = ex_jpeg_decode2(final_Cd,final_Ac,DCTAB,ACTAB,QTAB,H,W);
imshow(out_mat);

ratio = my_Ratio(hall_gray,final_Ac,final_Cd);
disp("Compress_ratio_2 = "+ratio);
disp("PSNR_2 = "+my_PSNR(hall_gray,out_mat));

ori = double(message)-48;
new = double(out_message) - 48;
l = length(ori);
right = sum(~xor(new,ori));
disp("正确率："+right/l+" ");
