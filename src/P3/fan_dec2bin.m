function y = fan_dec2bin(dec)
    flag = 1;
    if dec < 0 
        flag = 0;
        y = dec2bin(dec);
    else 
        y = dec2bin(dec);
    end
    y = double(y)-48;
    % 添加符号位
    if flag == 1
        y = [0,y];
    else
        y = [1,y];
    end
end