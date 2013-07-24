function  [k,D]= plane_3points(A,C,B)


AB= B-A;
AC=C-A;


k = cross(AB,AC);

D=k(1)*B(1)+k(2)*B(2)+k(3)*B(3);% ;opou D einai Ax+By+Cz=D!!! Alliws allazoume proshmo





