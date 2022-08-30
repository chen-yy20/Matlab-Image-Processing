% 仅用于一维数组比较
function y = my_equal(A,B)
    if length(A) ~= length(B)
        y = false;
    else
        temp = sum(A-B,"all");
        if temp == 0
            y = true;
        else
            y = false;
        end
        
    end
end
