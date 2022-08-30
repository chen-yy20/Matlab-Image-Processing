function y = my_dec2bin(x)
    y = double(dec2bin(abs(x)))-'0';
    if (x <0)
        y = ~y; % 注意是1补码
    elseif x == 0
        y = [];
    end
end