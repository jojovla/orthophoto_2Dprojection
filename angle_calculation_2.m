 function [az] = angle_calculation_2 (Dx, Dy)

az=atan(abs((Dx)/(Dy)));
if Dx>0 && Dy>0
    az;
    
    
    
elseif Dx>0 && Dy<0
    az=pi()-az;
    
    
    
elseif Dx<0 && Dy>0
    az=(2*pi())-az;
    
    
    
elseif  Dx<0 && Dy<0
    az=pi()+az;
    
    
elseif  Dx==0 && Dy>0
    az=0;
elseif  Dx==0 && Dy<0
    az=pi();
elseif  Dx>0 && Dy==0
    az=pi()/2;
elseif  Dx<0 && Dy==0
    az=3*(pi()/2);
end