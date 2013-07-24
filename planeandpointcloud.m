function [xma,yma,pros1,pros2] = planeandpointcloud(R,T,sa)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

xmax = max(T(:,1));
xmin = min(T(:,1));

ymax = max(T(:,2));
ymin = min(T(:,2));

zmax = max(T(:,3));
zmin = min(T(:,3));



if (sa)>0
           
          if R(1,1)<T(1,1)    
              xma=xmin;
              pros1=1;
              yma=ymin;
              pros2=1;
          else
              if R(1,1)>T(1,1)
                  
              xma=xmax;
              pros1=-1;
              yma=ymax;
              pros2=-1;
                  
    
              end
          end
                  
       
       else
           
          if sa<0
               
               if R(1,2)<T(1,2)
                   
              xma=xmax;
              pros1=-1;
              yma=ymin;
              pros2=1;
                   
               
                  
   
        
               else
                 if R(1,2)>T(1,2)
                     
              xma=xmin;
              pros1=1;
              yma=ymax;
              pros2=-1;
                       
      
       
                 end
               end
          end
       end


end

