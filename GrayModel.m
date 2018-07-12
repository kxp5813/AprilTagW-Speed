classdef GrayModel
    properties
        nobs
        dirty
        A=zeros(4,4)
        v=zeros(4)
        b=zeros(4)
        
    end
    methods
        function obj = GrayModel
            A=zeros(4,4)
            v=zeros(4)
            b=zeros(4)
            dirty = false
        end
        function addObservation(x,y,gray)
            xy = x*y
            
            a(0,0) = x*x+a(0,0)
            a(0,1) = x*y+a(0,1)
            a(0,2) = x*xy+a(0,2)
            a(0,3) = x+a(0,3)
            
            a(1,1) = y*y+a(1,1)
            a(1,2) = y*xy+a(1,2)
            a(1,3) = y+a(1,3)
            a(2,2) = xy*xy+a(2,1)
            a(2,3) = xy+a(2,2)
            a(3,3) = 1+a(2,3)
            
            b(0) = x*gray + b(0)
            b(1) = y*gray + b(1)
            b(2) = xy*gray + b(2)
            b(3) = gray + b(3)
            
            nobs = nobs +1
            
            dirty = true
        end
                   
        function bignumber = interpolate(x, y)
            if(dirty)
                compute()
            end
            bignumber = v(0)*x + v(1)*y + v(2)*x*y + v(3)
        end
        
        function compute()
            dirty = false
            if (nobs>=6)
                for i = 0:4
                    for j = i+1:4
                        A(j,i) = A(i,j)
                    end
                end
                det_unused = det(A)
                if det_unused == 0
                    invertible = false
                else
                    Ainv = inv(A)
                    v = Ainv *b
                end
            else
                v=0
                v(3) = b(3)/nobs
            end
        end
    end
end
        
                
                    
        
            
            