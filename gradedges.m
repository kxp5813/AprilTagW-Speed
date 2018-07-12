classdef gradedges
    properties
        cost
        pixela
        pixelb
        heft
        source
    end
    methods
       function obj = gradedges(costin,pixelstart,magofstart,pixelend)
           if nargin == 4
            obj.cost = costin;
            obj.pixela = pixelstart;
            obj.pixelb = pixelend;
            obj.heft = magofstart;
            obj.source = 0;
           elseif nargin > 3
               obj.cost = 0;
               obj.pixela = 0;
               obj.pixelb = 0;
               obj.heft = 0;
               obj.source = 0;
           end
       end
    end
    methods(Static)
        function edgesub = edgecost(theta0, theta1)
           thetaerr = abs(theta1-theta0);
            if (thetaerr>30)
                edgesub = -1;
                return
            end
            normErr = thetaerr / 30;
            edgesub=normErr*100;
            return
        end
    end
end
             
                
                
                
                
                
                
                
                
            
            
        