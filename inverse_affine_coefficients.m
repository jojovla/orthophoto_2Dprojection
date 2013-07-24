function [ A ] = inverse_affine_coefficients( a )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

A=zeros(8,1);
A_=a(1)*a(5)-(a(2)*a(4));
A(1)=(a(5)-a(6)*a(8))/A_;
A(2)=-(a(2)-a(3)*a(8))/A_;
A(3)=((a(2)*a(6))-(a(3)*a(5)))/A_;
A(4)=-(a(4)-a(6)*a(7))/A_;
A(5)=(a(1)-a(3)*a(7))/A_;
A(6)=-((a(1)*a(6))-(a(3)*a(4)))/A_;
A(7)=((a(4)*a(8))-(a(5)*a(7)))/A_;% sto 7 kai sto 8 afairesa ta meion...
A(8)=((a(2)*a(7))-(a(1)*a(8)))/A_;
end

