function y = my_bin2dec(x)
    flag = 0;
   
    if (x(1) == 0)
        x = ~x;
        flag = 1;
    end
    x = num2str(x);
    y = bin2dec(x);
    if flag == 1
        y = -y;
    end
    
end