function [im_last]=hole_fill(im)

im=double(im);

rows=size(im,1);
cols=size(im,2);

im_new=im;



for i=30:rows-1
    for j =20:cols-1
        
        if im(i,j,1)==0&&im(i,j,2)==0&&im(i,j,3)==0
            t=0;
            
            if im(i-1, j-1,1) ~=0 ||  im(i-1, j-1,2) ~=0 || im(i-1, j-1,3) ~=0 
                t=t+1;
            end
            
            if im(i, j-1,1)~=0|| im(i, j-1,2)~=0||im(i, j-1,3)~=0
                t=t+1;
            end
            
               
            if im(i+1,j-1,1)~=0|| im(i+1,j-1,2)~=0||im(i+1,j-1,3)~=0
                t=t+1;
            end
            
             if im(i-1,j,1)~=0|| im(i-1,j,2)~=0||im(i-1,j,3)~=0
                t=t+1;
             end
            
             if im(i+1,j,1)~=0|| im(i+1,j,2)~=0||im(i+1,j,3)~=0
                t=t+1;
             end
             
             
             if im(i-1,j+1,1)~=0|| im(i-1,j+1,2)~=0||im(i-1,j+1,3)~=0
                t=t+1;
             end
             
             if im(i,j+1,1)~=0|| im(i,j+1,2)~=0||im(i,j+1,3)~=0
                t=t+1;
             end
             
             if im(i+1,j+1,1)~=0|| im(i+1,j+1,2)~=0||im(i+1,j+1,3)~=0
                t=t+1;
             end
             
             
            if t>1
                im_new(i,j,1)=(im(i-1, j-1,1) + im(i, j-1,1) + im(i+1,j-1,1) + im(i-1,j,1) + im(i+1,j,1) + im(i-1,j+1,1) + im(i,j+1,1) + im(i+1,j+1,1) )/t;
                im_new(i,j,2)=(im(i-1, j-1,2) + im(i, j-1,2) + im(i+1,j-1,2) + im(i-1,j,2) + im(i+1,j,2) + im(i-1,j+1,2) + im(i,j+1,2) + im(i+1,j+1,2) )/t;
                im_new(i,j,3)=(im(i-1, j-1,3) + im(i, j-1,3) + im(i+1,j-1,3) + im(i-1,j,3) + im(i+1,j,3) + im(i-1,j+1,3) + im(i,j+1,3) + im(i+1,j+1,3) )/t;
           
            end
       
        end
        
    end
  
  
    
end

im_last=uint8(im_new);
        
end
    