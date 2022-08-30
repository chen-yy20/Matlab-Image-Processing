function y = in_mat2(mat,message)
    [h,w] = size(mat);
    new_mat = reshape(mat,h*w,1);
    bin_mat = [];
    for i = 1:length(message)
        a = new_mat(i,1);
        cur = fan_dec2bin(a);
        cur(end) = double(message(i))-48;
        %disp(i);
        %disp(cur(end));
        cur = fan_bin2dec(cur);
        %disp(cur);
        bin_mat = [bin_mat;cur];
    end
    y = reshape(bin_mat,[h,w]);

end