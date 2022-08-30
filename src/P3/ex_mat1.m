function message = ex_mat1(mat,len)
    y = dec2bin(mat);
    message = [];
    for i = 1:len
        cur = y(i,:);
        message = [message,cur(end)];
    end
end