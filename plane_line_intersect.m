function [point]= plane_line_intersect(n,lo,l,D)
% n the normal vector of the plane
% lo point on the line
% l direction vector of line
% plane equation n1*X+n2*Y+n3*Z)=D
% (xyz)=lo+tl
% xa=lo(1)+t*l(1)
% xb=lo(2)+t*l(2)
% xc=lo(3)+t*l(3)
% 
% D=n(1)*(lo(1)+t*l(1))+n(2)*lo(2)+t*l(2)+n(3)*lo(3)+t*l(3)

a=sum(n.*l);

b=sum(n.*lo);
t=(D-b)/a;

point= [lo(1)+l(1)*t,lo(2)+l(2)*t, lo(3)+l(3)*t];