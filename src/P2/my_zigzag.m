function Z = my_zigzag(A)
    si = size(A);
    if si(1) ~= si(2)
        error("不是方阵！");
    end
    N = si(1);
    Z = zeros(N^2,1);
    x = 1;
    y = 1;
    flag = 0; % 1↙ 0↗
    for i = 1:N
        for j = 1:N
            Z((i-1)*N+j,1) = A(x,y);
            if (x == 1) && (flag == 0) &&(y ~= N)
                y = y+1;
                flag = 1;
            elseif (y == 1) && (flag == 1) && (x ~= N)
                x  = x+1;
                flag = 0;
            elseif (x == N) && (flag == 1)
                y = y+1;
                flag = 0;
            elseif (y == N) && (flag == 0)
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
end