function [ pointcloud ] = crop_pointcloud(point,pc,lvec, Dx, Dy)

 kl=abs(lvec(1)/lvec(2)); %klish arxikhs eikonas kata XY
gon=atan(kl); %gwnia ws pros x axona


Dx=(Dx*1)/2;
Dy=(Dy*1.5)/2;

X1=point(1)-Dx*cos(gon);
X2=point(1)+Dx*cos(gon);
Y1=point(2)-Dx*sin(gon);
Y2=point(2)+Dx*sin(gon);
Zmx=point(3)+Dy;
Zmn=point(3)-Dy;

Xmx=max(X1,X2);
Xmn=min(X1,X2);
Ymx=max(Y1,Y2);
Ymn=min(Y1,Y2);


T = zeros(size(pc));%..vriskw provoles twn shmeiwn
cont=numel(T(:,1));
v=(1:cont);


lvec(3)=0;

for i=1:cont
    d=-(lvec(1)*point(1)+lvec(2)*point(2)+lvec(3)*point(3));
    t=-((lvec(1)*pc(i,1)+lvec(2)*pc(i,2)+lvec(3)*pc(i,3))+d)/(lvec(1)^2+lvec(2)^2+lvec(3)^2);
    T(i,1)=lvec(1)*t+pc(i,1);
    T(i,2)=lvec(2)*t+pc(i,2);
    T(i,3)=lvec(3)*t+pc(i,3);
end

T=[v',T];

    
 Q=T(T(:,2)<Xmx & T(:,2)>Xmn , :);
 W=Q(Q(:,3)<Ymx & Q(:,3)>Ymn, :);
 V=W(Q(:,4)<Zmx & W(:,4)>Zmn, :);
 
 pointcloud=pc(V(:,1),:);

end

