function [whole_mat,out] = ex_jpeg_decode3(final_Cd,final_Ac,DCTAB,ACTAB,QTAB,H,W)
    % 直流分量解码
    dctab = DCTAB(:,2:end);
    [~,w] = size(final_Cd);
    num = 0;
    k = 1;
    huffman = [];
    tar = [];
    di_Cdi = [];
    is_zero = 0;
    
    for i = 1:w
        cur = final_Cd(i);
        if is_zero
            di_Cdi = [di_Cdi,0];
            is_zero = 0;
        end
        if num ~= 0
            tar = [tar,cur];
            num = num -1;
            if num == 0
                di_Cdi = [di_Cdi, my_bin2dec(tar)];
                tar = [];
            end
        else
            huffman = [huffman,cur];
            for j = 1:12
                n = DCTAB(j,1);
                if (length(huffman) == n)
                    if(huffman == dctab(j,1:n))
                        num = j-1;
                        huffman = [];
                        if (num == 0)
                            is_zero = 1;
                        end
                    end
              
                end
            end
        end
    end
    [~,w] = size(di_Cdi);
    Cdi = zeros(1,w);
    % 差分计算
    for i = 1:w
        if i == 1
            Cdi(i) = di_Cdi(i);
        else
            Cdi(i) = Cdi(i-1)-di_Cdi(i); 
        end
    end
    
    % 交流分量解码
    ZRL = [1,1,1,1,1,1,1,1,0,0,1];
    EOB = [1,0,1,0];
    meet_eob = 0;
    meet_zrl = 0;
    
    actab = ACTAB(:,4:end);
    [~,w] = size(final_Ac);
    
    
    num = 0;
    k = 1;
    huffman = [];
    ac_tar = [];
    Aci = [];
    temp_col = [];
    run_i = 0;
    
    for i = 1:w
        cur = final_Ac(i);
        if meet_zrl
            temp_col = [temp_col;zeros(16,1)];
            meet_zrl = 0;
            huffman = [];
        end
        if meet_eob
            temp_col = [temp_col;zeros(63-length(temp_col),1)];
            Aci = [Aci,temp_col];
            temp_col = [];
            huffman = [];
            meet_eob = 0;
        end
    
        if run_i~=0||num~=0
            if run_i ~= 0
                temp_col = [temp_col;zeros(run_i,1)];
                run_i = 0;
            end
            if num ~= 0
                ac_tar = [ac_tar,cur];
                num = num -1;
                if num == 0
                    temp_col = [temp_col; my_bin2dec(ac_tar)];
                    ac_tar = [];
                end
            end
        else
            huffman = [huffman,cur];
            for j = 1:160
                n = ACTAB(j,3);
                if (isequal(huffman,EOB))
                    meet_eob = 1;           
                elseif isequal(huffman,ZRL)
                    meet_zrl = 1;      
                elseif(isequal(huffman,actab(j,1:n)))
                    run_i = ACTAB(j,1);
                    num = ACTAB(j,2);
                    huffman = [];
                end
              
               
            end
        end
    end
    if meet_eob
        temp_col = [temp_col;zeros(63-length(temp_col),1)];
        Aci = [Aci,temp_col];
        temp_col = [];
        huffman = [];
        meet_eob = 0;
    end
    
    % 反zigzag 与 idct 与拼接
    AcDc = [Cdi;Aci];
    [h,w] = size(AcDc);
    whole_mat = [];
    out = [];
    for i = 1:H/8  % 15
        row = [];
        for j = 1:W/8  % 21
            current = AcDc(:,(i-1)*(W/8)+j);   
            % ------------------提取信息-------------------
            for p = 0:63
                idx = 64-p;
                if current(idx) ~= 0
                    this_message = current(idx);
                    break;
                end
            end
            out = [out,this_message];
            %---------------------------------------------
            cur_mat = my_izigzag(current);
            cur_mat = cur_mat.*QTAB;
            new_mat = idct2(cur_mat);
            new_mat = round(new_mat)+128;
            new_mat = uint8(new_mat);
            row = [row,new_mat];
        end
        whole_mat = [whole_mat;row];
    
    end
end