function r = input_sys(t, flag)

% r takes rad values.
if flag == true
    
    if (t >= 1 && t < 10) || (t >= 90 && t < 98)
        r = pi/36;

    elseif (t >= 22 && t < 35) || (t >= 110 && t < 120)
        r = -pi/36;

    elseif t >= 45 && t < 55
        r = pi/18;

    elseif t >= 65 && t < 75
        r = -pi/18;

    else
        r = 0;
        
    end
        
else
   r = 0.1745*sin(t); 
   
end
      
end