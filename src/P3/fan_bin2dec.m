function y = fan_bin2dec(bin)
    len = length(bin); 
   
    flag = 0;
    if bin(1) == 1
         % 先做减一运算
        borrow = 1;
        for j = 0:len-1
            i = len - j;
            if borrow == 1
                if bin(i) == 1
                    bin(i) = 0;
                    borrow = 0;
                else
                    bin(i) = 1;
                    borrow = 1;
                end
            end
        end
        bin = ~bin;
        flag = 1;
    end
    num = num2str(bin);
    num(num==' ') = [];
    y = bin2dec(num);
    if flag == 1
        y = -y;
    end
end