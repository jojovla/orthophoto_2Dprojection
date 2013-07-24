function [ax1,ax2,ax3,ax4,ax5,ax6]=axis_margin(R,Xo,Yo,Zo)

R1=max(R,[],1);
R2=min(R,[],1);

if Xo>R1(1)
    R1(1)=Xo;
else
    if Xo<R2(1)
        R2(1)=Xo;
        
    end
end

if Yo>R1(2)
    R1(2)=Yo;
else
    if Yo<R2(2)
        R2(2)=Yo;
        
    end
end

if Zo>R1(3)
    R1(3)=Zo;
else
    if Zo<R2(3)
        R2(3)=Zo;
        
    end
end

ax1=floor(R2(1)-1);
ax2=ceil(R1(1)+1);
ax3=floor(R2(2)-1);
ax4=ceil(R1(2)+1);
ax5=floor(R2(3)-1);
ax6=ceil(R1(3)+1);


