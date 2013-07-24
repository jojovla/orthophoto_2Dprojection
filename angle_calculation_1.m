function [ a ] = angle_calculation_1( Dx,Dy)


sa=Dy/Dx;
if sa>0
    if Dx>0
        a=-atan(abs(sa));
    else if Dx<0
        a=pi()-atan(abs(sa));
        end
    end
    
else if sa<0
    if Dx>0
        a=atan(abs(sa));
        
    else
        if Dx<0
        a=pi()+atan(abs(sa));
        end
    end
        
        
    end
end

