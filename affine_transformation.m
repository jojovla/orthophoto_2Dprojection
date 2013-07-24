function [ xdyd, affine_coeff ] = affine_transformation( e,kx,ky,k0,k1,k2,p1,p2,xy,xo,yo,xom,yom )

% afinikos
% suntelestes
a1=kx*((cos(pi())*cos(e+pi()))+ (sin(e+pi())*sin(pi())));  % strefw ton aksona x aneksarthta apo ton y kata 180 degrees (kathraptisma) gia uto prosthetw 180 kai e pou einai h orthogwnikothta
a2=kx*((-sin(pi())*cos(e+pi()))+(sin(e+pi())*cos(pi())));
b1=ky*sin(pi());
b2=ky*cos(pi());
c1=-xo;
c2=yo;
% 
% gon=pi());
% 
% 
% R_affine=[cos(gon),sin(gon);-sin(gon),cos(gon)];
% xy_str=xy';
% xy_new=zeros(size(xy_str));
% for i=1:size(xy,1)
% xy_new(:,i)=R_affine*xy_str(:,i);
% end
% x_new=xy_new'
% x_n=[x_new(:,1),-x_new(:,2);
% x_tel=x_n
%--------------------------aplh metathesh kai enallagh axonwn xwris e!!!!
xyn=[xy(:,1),-xy(:,2)];
    
x_tel=(xyn(:,1)-xo)*0.0064;
y_tel=(xyn(:,2)+yo)*0.0064;
xy_tel=[x_tel,y_tel];
%_______________________________________________________
affine_coeff =[a1 b1 c1 ; a2 b2 c2 ; 0 0 1];

x=zeros(size(xy,1),1);
y=zeros(size(xy,1),1);
r=zeros(size(xy,1),1);
Dr=zeros(size(xy,1),1);
Dx=zeros(size(xy,1),1);
Dy=zeros(size(xy,1),1);
dx=zeros(size(xy,1),1);
dy=zeros(size(xy,1),1);
xd=zeros(size(xy,1),1);
yd=zeros(size(xy,1),1);

for i=1:size(xy,1)
   
 x(i,1)=(a1*xy(i,1)+b1*xy(i,2)+c1)*0.0064; % metatroph px se mm (0.0064mm to megetho tou pixel)
 y(i,1)=(a2*xy(i,1)+b2*xy(i,2)+c2)*0.0064; 

r(i,1) = sqrt( (x(i,1)-xom)^2 + (y(i,1)-yom)^2);
Dr(i,1)=k0*r(i,1) + k1*r(i,1)^3 + k2*r(i,1)^5 ; % aktinikh diastrofh
    
    %analush tou dianusmatos Dr stis sunistwses Dx, Dy
Dx(i,1)=(Dr(i,1)*x(i,1))/r(i,1);    
Dy(i,1)=(Dr(i,1)*y(i,1))/r(i,1);

dx(i,1)=2*p2*(x(i,1)-xom)*(y(i,1)-yom) + p1*(r(i,1)^2 + 2*(x(i,1)-xom)^2); % assumetrh paramorfwsh
dy(i,1)=p2*(r(i,1)^2 + 2*(y(i,1)-yom)^2) + 2*p1*(x(i,1)-xom)*(y(i,1)-yom); % assumetrh paramorfwsh

xd(i,1)=x(i,1)-Dx(i,1)-dx(i,1);
yd(i,1)=y(i,1)-Dy(i,1)-dy(i,1);

end

xdyd(:,1)=xd;
xdyd(:,2)=yd;
end
