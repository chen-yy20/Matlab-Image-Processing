function y = my_idct(C,mode)
    if nargin==1
        mode = "normal";
    end
    temp = size(C);
    if (temp(1)~=temp(2))
        error("不是方阵！")
    else
        N = temp(1);
    end

    D = zeros(N);
    D(1,:) = sqrt(.5).*ones(1,N);
    for i=2:N
        for j=1:N
            D(i,j) = cos((i-1)*(2*j-1)*pi/(2*N));
        end
    end
    switch mode
        case "normal"
            D = D;
        case "left"
            if(N<4)
                error("矩阵过小，模式不适用")
            else
                D(:,1:4) = zeros(N,4);
            end
        case "right"
            if(N<4)
                error("矩阵过小，模式不适用")
            else
                D(:,N-3:N) = zeros(N,4);
            end
        otherwise
            error("无此模式")

    end
    D = sqrt(2/N).*D;
    C = D'*C*D;
    y = C;


end