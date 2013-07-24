function [ xdyd ] = rotation_and_translation( xy,im,pixelsize)
 
% rotation and translation only without affine transformation and correction of distortion 
rows=size(im,1);
cols=size(im,2);
a1=cos(pi());
b1=sin(pi());
c1=-cols/2;
d1=rows/2;
 

xd=zeros(size(xy,1),1);
yd=zeros(size(xy,1),1);
 
for i=1:size(xy,1)
   
 xd(i,1)=(a1*(-1)*xy(i,1)+b1*xy(i,2)+c1)*pixelsize; 
 yd(i,1)=(-b1*(-1)*xy(i,1)+a1*xy(i,2)+d1)*pixelsize;   
 
end
xdyd(:,1)=xd;
xdyd(:,2)=yd;
end
