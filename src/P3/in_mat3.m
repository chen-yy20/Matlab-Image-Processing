function y = in_mat3(mat,message)
    a = mat(1:3,1:3);
    y = mat;
    new_mat = reshape(a,9,1);
    bin_mat = [];
    for i = 1:length(message)
        b = new_mat(i,1);
        cur = fan_dec2bin(b);
        cur(end) = double(message(i))-48;
        %disp(i);
        %disp(cur(end));
        cur = fan_bin2dec(cur);
        %disp(cur);
        bin_mat = [bin_mat;cur];
    end
    a = reshape(bin_mat,[3,3]);
    y(1:3,1:3) = a;

end