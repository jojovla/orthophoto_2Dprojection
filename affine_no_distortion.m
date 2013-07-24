function [ xdyd ] = affine_no_distortion( e,kx,ky,xy,xo,yo,pixelsize )

% affine transformation without the correction of lens' distortion 
a1=kx*((cos(pi())*cos(e+pi()))+ (sin(e+pi())*sin(pi())));  
a2=kx*((-sin(pi())*cos(e+pi()))+(sin(e+pi())*cos(pi())));
b1=ky*sin(pi());
b2=ky*cos(pi());
c1=-xo;
c2=yo;


xd=zeros(size(xy,1),1);
yd=zeros(size(xy,1),1);

for i=1:size(xy,1)
   
 xd(i,1)=(a1*xy(i,1)+b1*xy(i,2)+c1)*pixelsize; 
 yd(i,1)=(a2*xy(i,1)+b2*xy(i,2)+c2)*pixelsize;	


end
xdyd(:,1)=xd;
xdyd(:,2)=yd;
end
