function [X_px2] = distortion_inverse_affine(x,y,xom,yom,p1,p2,k0,k1,k2,affine_coeff)


% radial distortion      
radial = sqrt( (x-xom)^2 + (y-yom)^2);
Dr=k0*radial + k1*radial^3 + k2*radial^5 ; % aktinikh diastrofh
%analush tou dianusmatos Dr stis sunistwses Dx, Dy
Dx=(Dr*x)/radial;    
Dy=(Dr*y)/radial;

dx=2*p2*(x-xom)*(y-yom) + p1*(radial^2 + 2*(x-xom)^2); % assumetrh paramorfwsh

dy=p2*(radial^2 + 2*(y-yom)^2) + 2*p1*(x-xom)*(y-yom); % assumetrh paramorfwsh
xd=x+Dx+dx;
yd=y+Dy+dy;
      
x=xd; % einai se mm diorthomena apo aktinikh
y=yd;
         
A=affine_coeff;
         
X=[x/0.0064 ; y/0.0064 ;1];
X_=A\X;  % anastrofos A  * dianusma X pou periexei ta x,y se mm , ta opoia diairw  me to megethos tou pixel (0.0064 mm) gia na prokupsoun pixel )
X_px(1,:) = X_(1:2);  % vazw kathe fora ta x,y se enan pinaka se mia grammh kai afairw tautoxrona thn trith grammh pou einai 1. Apotelesma enas pinaka nx2 , h prwth sthlh exei ta x kai h deuterh sthlh ta y
X_px2=X_px;

end

