function y = my_Ratio(input,Ac,Dc)
    a = size(input);
    byte_num = a(1)*a(2);
    input = 8*byte_num;
    
    a = size(Ac);
    Ac_num = a(2);
    
    a = size(Dc);
    Dc_num = a(2);
    
    output = Ac_num+Dc_num;
    y = input/output;
end