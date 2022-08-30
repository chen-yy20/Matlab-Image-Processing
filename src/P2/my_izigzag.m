function Z = my_izigzag(A)
    [h,~] = size(A);
    if h ~= 64
        error("输入向量长度应为64");
    end
    Z = zeros(8,8);
    x = 1;
    y = 1;
    cnt = 1;
    flag = 0; % 1↙ 0↗
    for cnt = 1:64
        Z(x,y) = A(cnt);
        if (x == 1) && (flag == 0) &&(y ~= 8)
            y = y+1;
            flag = 1;
        elseif (y == 1) && (flag == 1) && (x ~= 8)
            x  = x+1;
            flag = 0;
        elseif (x == 8) && (flag == 1)
            y = y+1;
            flag = 0;
        elseif (y == 8) && (flag == 0)
            x = x+1;
            flag = 1;
        elseif flag == 1
            x = x+1;
            y = y-1;
        elseif flag == 0
            x = x-1;
            y = y+1;
        end
    end
end