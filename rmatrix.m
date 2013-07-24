function [r]=rmatrix(w,f,k)



r=[ cos(f)*cos(k) cos(w)*sin(k)+sin(w)*sin(f)*cos(k) sin(w)*sin(k)-cos(w)*sin(f)*cos(k)
   -cos(f)*sin(k) cos(w)*cos(k)-sin(w)*sin(f)*sin(k) sin(w)*cos(k)+cos(w)*sin(f)*sin(k)
    sin(f)       -sin(w)*cos(f)                      cos(w)*cos(f)];

