
 function [a,So] = projective2D_coefficients (XY, xy)

n=2*size(XY,1);
m=8; 

%gemisma tou pinaka A
A=sym(zeros(n,m));
syms a11 a12 a13  a21 a22 a23  a31 a32 ;

q=[a11 a12 a13  a21 a22 a23 a31 a32]; % oi agnwstes parametroi pou zhtame na vroume 

k=1;
for i=1:size(XY,1)
    
%sumplhrwsh twn sthlwn 1:6
X_=a11*xy(k,1)+a12*xy(k,2)+a13-a31*xy(k,1)*XY(k,1)-a32*xy(k,2)*XY(k,1); % h prwth eksiswsh tou provolikou metasxhmatismou 
A(2*i-1,:)=jacobian(X_,q); %merikes paragwgoi ths x ws pros to dianusma q pou oeriexei tis agnwstes parametrous(den xreiazomaste proswrines times giati einai grammikes oi sxeseis ws pros tous agnwstous)
Y_=a21*xy(k,1)+a22*xy(k,2)+a23-a31*xy(k,1)*XY(k,2)-a32*xy(k,2)*XY(k,2); % h deuterh eksiswsh  tou provolikou metasxhmatismou 
A(2*i,:)=jacobian(Y_,q);

k=k+1;
end
A=eval(A);

l=zeros(n,1);
%O pinakas l me ta stoixeia X1, Y1 , X2, Y2 .... X7, Y7
for q=1:size(XY,1)
l(2*q-1,1)=XY(q,1);
l(2*q,1)=XY(q,2);
end

% oi times twn parametrwn a11.....ktl me thn seira pou fainontai sta syms
% se mia sthlh


X=inv(A'*A)*A'*l; 
a=X;
% euresh upoloipwn

u=l-A*X;

N=A'*A;
So=sqrt((u'*u)/(n-m)); %aposteriori tupiko sfalma 
Vx=So^2*inv(N); %aposteriori pinakas metavlhtothtas-summetavlhtothtas

