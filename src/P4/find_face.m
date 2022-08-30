function new_pic = find_face(pic,v,L,acc)
    name = ['v',num2str(L),'.mat'];
    [H,W,~] = size(pic);
    h = 30;
    w = 30;
    rem = [];
    ijrem = [];
    for i = 1:10:H-h+1
        for j = 1:10:W-w+1
            part = pic(i:i+h-1,j:j+w-1,:);
            u = get_u(part,L);
            ang = dot(u,v)/(norm(u)*norm(v));
            % imshow(part);
            rem = [rem,ang];
            ijrem = [ijrem,[i,j]'];
        end
    end
    [~,locs] = findpeaks(rem,"MinPeakHeight",max(rem)/(2.2-acc));
    new_pic = pic;
    for i = 1:length(locs)
        x = ijrem(1,locs(i));
        y = ijrem(2,locs(i));
        % part = new_pic(x:x+19,y:y+19,:);
        new_pic(x:x+5,y:y+w-1,1) = 255;
        new_pic(x+h-6:x+h-1,y:y+h-1,1) = 255;
        new_pic(x:x+h-1,y:y+5,1) = 255;
        new_pic(x:x+h-1,y+2-6:y+w-1,1) = 255; 
    end
    ijrem = [];
    % ---------------------------- 挖空 ------------------------------
    for i = 1:H
        for j = 1:W
            if new_pic(i,j,1) == 255
                inside = 1;
                for m = 1:3
                    if i+m<=H&&new_pic(i+m,j,1) ~= 255
                        inside = 0;
                        break;
                    end
                    if i-m>=1&&new_pic(i-m,j,1) ~= 255
                        inside = 0;
                        break;
                    end
                    if j+m<=W&&new_pic(i,j+m,1) ~= 255
                        inside = 0;
                        break;
                    end
                    if j-m>=1&&new_pic(i,j-m,1) ~= 255
                        inside = 0;
                        break;
                    end
                    if j-m>=1&&i-m>=1&&new_pic(i-m,j-m,1) ~= 255
                        inside = 0;
                        break;
                    end
                    if j-m>=1&&i+m<=H&&new_pic(i+m,j-m,1) ~= 255
                        inside = 0;
                        break;
                    end
                    if j+m<=W&&i+m<=H&&new_pic(i+m,j+m,1) ~= 255
                        inside = 0;
                        break;
                    end
                    if j+m<=W&&i-m>=1&&new_pic(i-m,j+m,1) ~= 255
                        inside = 0;
                        break;
                    end
                end
                if inside == 1
                    ijrem = [ijrem,[i,j]'];
                end
            end
        end
    end
    [~,l] = size(ijrem);
    for i = 1:l
        new_pic(ijrem(1,i),ijrem(2,i)) = pic(ijrem(1,i),ijrem(2,i));
    end
    % -----------------------------------------------------------------------
end
