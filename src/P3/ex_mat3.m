function message = ex_mat3(mat,len)
    a = mat(1:3,1:3);
    a = reshape(a,9,1); 
    message = [];
    for i = 1:len
        % disp(a(i));
        cur = fan_dec2bin(a(i));
%         disp(i);
%         disp(a(i));
%         disp(cur(end));
        message = [message,cur(end)];
    end
    message = num2str(message);
    message(message == ' ') = [];
end