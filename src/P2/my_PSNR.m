function y = my_PSNR(origin,new)
    [H,W] = size(origin);
    Pixel_Num = H*W;
    atemp = double(origin-new);
    temp = atemp.^2./Pixel_Num;
    MSE = sum(temp,"all");
    PSNR = 10*log10(255^2/MSE);
    y = PSNR;
end