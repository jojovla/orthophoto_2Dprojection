function [ proswrines_times ] = dlt_initial(n,m,xy,XYZ,xom,yom)

%ta stoixeia xo,yo ths fwtografias , analoga an einai strammenh h photo allazoun
%gemisma tou pinaka A
A=sym(zeros(n,m));
syms b11 b12 b13 b14 b21 b22 b23 b24 b31 b32 b33;
q=[b11 b12 b13 b14 b21 b22 b23 b24 b31 b32 b33]; % oi agnwstes parametroi pou zhtame na vroume 

k=1;
for i=1:size(xy,1)
%sumplhrwsh twn sthlwn 1:10
x=b11*XYZ(k,1)+b12*XYZ(k,2)+b13*XYZ(k,3)+b14-b31*xy(k,1)*XYZ(k,1)-b32*xy(k,1)*XYZ(k,2)-b33*xy(k,1)*XYZ(k,3); % h prwth eksiswsh tou metasxhmatismou DLT
A(2*i-1,:)=jacobian(x,q); %merikes paragwgoi ths x ws pros to dianusma q pou oeriexei tis agnwstes parametrous(den xreiazomaste proswrines times giati einai grammikes oi sxeseis ws pros tous agnwstous)
y=b21*XYZ(k,1)+b22*XYZ(k,2)+b23*XYZ(k,3)+b24-b31*xy(k,2)*XYZ(k,1)-b32*xy(k,2)*XYZ(k,2)-b33*xy(k,2)*XYZ(k,3); % h deuterh eksiswsh  tou metasxhmatismou DLT
A(2*i,:)=jacobian(y,q);

k=k+1;
end
A=eval(A);

%O pinakas l me ta stoixeia x1, y1 , x2, y2 .... x7, y7
l=zeros(size(xy,1),1);
for q=1:size(xy,1)
l(2*q-1,1)=xy(q,1);
l(2*q,1)=xy(q,2);
end

X=(A'*A)\A'*l; % oi times twn parametrwn b11.....ktl me thn seira pou fainontai sta syms  \=inv

%euresh proswrinwn timwn
g1(1,:)=X(1:3,1);
g1(2,:)=X(5:7,1);
g1(3,:)=X(9:11,1);
g2(1:3,1)=[X(4);X(8);1];
XoYoZo=-inv(g1)*g2;
w=atan(-X(10,1)/X(11,1));
f=atan(-sin(w)*(X(9,1)/X(10,1)));
k=atan((X(5)-yom*X(9))/(X(1)-xom*X(9)));

proswrines_times=[XoYoZo;w;f;k];

u=A*X-l;
N=A'*A;
So=sqrt((u'*u)/(n-m)); %aposteriori tupiko sfalma 
%Vx=So^2*inv(N); %aposteriori pinakas metavlhtothtas-summetavlhtothtas


