function [ n ] = line_direction( n_line, R,T )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here




n=n_line;

sa=-(n_line(1)/n_line(2));

n_line= abs(n_line);

if R(1,3)>T(1,3)
if (sa)>0
           
          if R(1,1)<T(1,1) 
              
             n(1)=-n_line(1);
             n(2)=-n_line(2);
          else
              if R(1,1)>T(1,1)
                  
             
                n(1)=n_line(1);
                n(2)=n_line(2);  
    
              end
          end
                  
       
       else
           
          if sa<0
               
               if R(1,2)<T(1,2)
                   
             n(1)=n_line(1);
             n(2)=-n_line(2);
                   
               
                  
   
        
               else
                 if R(1,2)>T(1,2)
                     
              n(1)=-n_line(1);
             n(2)=n_line(2);
                       
      
       
                 end
               end
          end
end
elseif R(1,3)<T(1,3)
    if (sa)>0
           
          if R(1,1)<T(1,1) 
              
             n(1)=n_line(1);
             n(2)=n_line(2);
          else
              if R(1,1)>T(1,1)
                  
             
                n(1)=-n_line(1);
                n(2)=-n_line(2);  
    
              end
          end
                  
       
       else
           
          if sa<0
               
               if R(1,2)<T(1,2)
                   
             n(1)=-n_line(1);
             n(2)=n_line(2);
                   
               
                  
   
        
               else
                 if R(1,2)>T(1,2)
                     
              n(1)=n_line(1);
             n(2)=-n_line(2);
                       
      
       
                 end
               end
          end
     end
end


