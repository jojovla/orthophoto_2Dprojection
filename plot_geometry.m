function []= plot_geometry(R,r,plane_coeff,Xo,Yo,Zo,proj_center)

[ax1 ax2 ax3 ax4 ax5 ax6]=axis_margin(R,Xo,Yo,Zo); %function gia na vrw tous axones gia to plot




t=linspace(-100,110);          %ektupwnw ton axona lhpshs
 X=Xo+r(3,1)*t;Y=Yo+r(3,2)*t;Z=Zo+r(3,3)*t ;
 plot3(X,Y,Z); grid on
 hold on   % me thn entolh hold on kratw to figure anoixto kai sunexizw na ektypwnw
           % se ayto
 
  
axis equal 
axis([ax1 ax2 ax3 ax4 ax5 ax6])% ta oria twn axonwn x,y,z pou tha fainontai

% diereunhse to + cos h sin ths gwnias gia na mhn vgainei terastio!!

%scatter(point(1),point(2),point(3),'MarkerFaceColor','r','MarkerEdgeColor','g')

 d1=proj_center(2)-3:1:proj_center(2)+3; % ektypwnw to epipedo
 d2=proj_center(3)-3:1:proj_center(3)+3;
[Z,Y] = meshgrid(d2,d1);
X=proj_center(1)+(plane_coeff(2)*((proj_center(2)-Y)+plane_coeff(3)*(proj_center(3)-Z))/plane_coeff(1));
mesh(X,Y,Z)


% 
%  d3=proj_center(1)-3:1:proj_center(1)+3;
% [X,Y]=meshgrid(d3,d1);
% Z=proj_center(3)+(plane_coeff(2)*((proj_center(2)-Y)+plane_coeff(1)*(proj_center(1)-X))/plane_coeff(3));
% mesh(X,Y,Z)



% 
% T = zeros(size(R));%..vriskw provoles twn shmeiwn
% 
% for i=1:cont
%     d=-(plane_coeff(1)*proj_center(1)+plane_coeff(2)*proj_center(2)+plane_coeff(3)*proj_center(3));
%     t=-((plane_coeff(1)*R(i,1)+plane_coeff(2)*R(i,2)+plane_coeff(3)*R(i,3))+d)/(plane_coeff(1)^2+plane_coeff(2)^2+plane_coeff(3)^2);
%     T(i,1)=plane_coeff(1)*t+R(i,1);
%     T(i,2)=plane_coeff(2)*t+R(i,2);
%     T(i,3)=plane_coeff(3)*t+R(i,3);
% end
% % 
% 
% jjj=plane_coeff(:)/norm(plane_coeff);
% 
% gon=((pi()/2)-acos(jjj(3)))*180/pi();
% n=cross(jjj,[0,0,1]);
% n=n(:)/norm(n);
% [K, Rr, t] = AxelRot(T', gon, n, proj_center);
% K=K';
% 
% 
% 
% t=linspace(-100,110);          %ektupwnw ton axona lhpshs
%  X=Xo+n(1)*t;Y=Yo+n(2)*t;Z=Zo+n(3)*t ;
%  plot3(X,Y,Z); grid on
%  hold on  
%  
%  
%  
% 
% scatter3(K(1:vhma:cont,1),K(1:vhma:cont,2),K(1:vhma:cont,3),'MarkerFaceColor','r','MarkerEdgeColor','r')
% scatter3(T(1:vhma:cont,1),T(1:vhma:cont,2),T(1:vhma:cont,3),'MarkerFaceColor','b','MarkerEdgeColor','b')
% 
% 
% 
% 
% 


cont=numel(R(:,1));
if cont>1000
vhma=floor(cont/1000);
scatter3(R(1:vhma:cont,1),R(1:vhma:cont,2),R(1:vhma:cont,3),'MarkerFaceColor','b','MarkerEdgeColor','b') % ektypwnw endeiktiko nefos
else
scatter3(R(:,1),R(:,2),R(:,3),'filled') % ektypwnw olo to nefos an einai katw apo 1000 shmeia
end  
    
hold off


%title('Point Cloud, Optical Axis & Projection Plane')
xlabel('x axis')
ylabel('y axis')
zlabel('z axis');
