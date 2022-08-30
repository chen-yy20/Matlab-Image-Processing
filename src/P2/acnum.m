function y = acnum(run,time,ACTAB)
    
    for i = 1:160
        if (run == ACTAB(i,1))&&(time == ACTAB(i,2))
            length = ACTAB(i,3);
            y = ACTAB(i,4:3+length);
        end
    end
    
end