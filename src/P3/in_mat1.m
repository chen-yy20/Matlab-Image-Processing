function y = in_mat1(mat,message)
    [h,w] = size(mat);
    bin_mat = dec2bin(mat);
    for i = 1:length(message)
        cur = bin_mat(i,:);
        cur(end) = message(i);
        bin_mat(i,:) = cur;
    end
    y = bin2dec(bin_mat);
    y = reshape(y,[h,w]);

end