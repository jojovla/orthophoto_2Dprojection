function [ Xo,Yo,Zo,w,f,k ] =resection_eop( n,m,c_mm,xy,XYZ,proswrines_times,sunt_klimakas_of,H )
                
syms Xo Yo Zo w f k  
r=rmatrix(w,f,k); %pinakas strofhs R,pou periexetai sthn sunarthsh rmatrix 
A1=sym(zeros(n,6)); % diastaseis pinaka A (grammes oses oi parathrhseis n,sthles oses oi agnwstes parametroi (m=6) )
v=[Xo Yo Zo w f k ];  % agnwstes parametroi tou modelou,m=6 ( stoixeia tou ekswterikou prosanatolismou ths eikonas )
%gemisma tou pinaka A
k=1;
for i=1:2:n 
Fx=-c_mm*(r(1,1)*(XYZ(k,1)-Xo)+r(1,2)*(XYZ(k,2)-Yo)+r(1,3)*(XYZ(k,3)-Zo))/(r(3,1)*(XYZ(k,1)-Xo)+r(3,2)*(XYZ(k,2)-Yo)+r(3,3)*(XYZ(k,3)-Zo));%sunthhkh suggrammikothtas,Fx
A1(i,:)=jacobian(Fx,v);   %merikes paragwgoi ths Fx ws pros ta Xo,Yo,Zo,w,f,k antistoixa

Fy=-c_mm*(r(2,1)*(XYZ(k,1)-Xo)+r(2,2)*(XYZ(k,2)-Yo)+r(2,3)*(XYZ(k,3)-Zo))/(r(3,1)*(XYZ(k,1)-Xo)+r(3,2)*(XYZ(k,2)-Yo)+r(3,3)*(XYZ(k,3)-Zo)); %sunthhkh suggrammikothtas,Fy      
A1(i+1,:)=jacobian(Fy,v);  %merikes paragwgoi ths Fy ws pros ta Xo,Yo,Zo,w,f,k antistoixa

k=k+1;  
end

%prwswrines times
X=proswrines_times; %pinakas X me tis proswrines times tou ekswterikou prosanatolismou Xo Yo ZO w f k 
Xo=X(1);
Yo=X(2);
Zo=X(3);
w=X(4);
f=X(5);
k=X(6);

t=1;
flag=0;

while (flag==0)  
A=eval(A1);  %ypologismos you pinaka A me tis proswrines times 
%upologismos you pinaka dl:
r=rmatrix(w,f,k);
x_op=zeros(size(xy,1),1);  
y_op=zeros(size(xy,1),1);
for l=1:size(xy,1);
x_op(l)=-c_mm*(r(1,1)*(XYZ(l,1)-Xo)+r(1,2)*(XYZ(l,2)-Yo)+r(1,3)*(XYZ(l,3)-Zo))/(r(3,1)*(XYZ(l,1)-Xo)+r(3,2)*(XYZ(l,2)-Yo)+r(3,3)*(XYZ(l,3)-Zo));
y_op(l)=-c_mm*(r(2,1)*(XYZ(l,1)-Xo)+r(2,2)*(XYZ(l,2)-Yo)+r(2,3)*(XYZ(l,3)-Zo))/(r(3,1)*(XYZ(l,1)-Xo)+r(3,2)*(XYZ(l,2)-Yo)+r(3,3)*(XYZ(l,3)-Zo));
end
dl1=xy(:,1)-x_op;
dl2=xy(:,2)-y_op;
dl=zeros(n,1);
for q=1:size(xy)
    dl(2*q-1)=dl1(q);
    dl(2*q)=dl2(q);
end
N=A'*A; % pinakas N
dx=N\A'*dl;  %pinakas dx
X=X+dx ;        %pinakas X me tis kaluteres times tou ekswterikou prosanatolismou 
%enhmerwsh twn kainouriwn timwn
 Xo=X(1);
 Yo=X(2);
 Zo=X(3);
 w=X(4);
 f=X(5);
 k=X(6);
 
u=A*dx-dl; %pinakas upoloipwn
So=sqrt((u'*u)/(n-m)); %aposteriori tupiko sfalma 
Vx=So^2*inv(N); %aposteriori pinakas metavlhtothtas-summetavlhtothtas

flag=1;
sfalma_grammiko=(sunt_klimakas_of)*(0.00025)/2;
    sfalma_gwniako=sfalma_grammiko/H;
    
for i=1:3
    
if abs(dx(i))>sfalma_grammiko|| abs(dx(i+3))>atan(sfalma_gwniako)
    flag=0;
end
end
% if t==5
%     flag=1;
% else
%     flag=0;
% end


%t=t+1
end

end

