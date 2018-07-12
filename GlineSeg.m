classdef GlineSeg
    properties
        x0
        y0
        x1
        y1
        doubleline
        slope
        length
    end
    methods
        function obj = GlineSeg(x0in,y0in,x1in,y1in)
            invert = 0;%0 means leave as is 1 means switch
            img = imread('tag_middle.png');
            img=rgb2gray(img);
            obj.length = sqrt((x1in-x0in)^2+(y1in-y0in)^2);
            obj.doubleline = 0;
            dy = (y1in-y0in);
            dx = (x1in-x0in);
            obj.slope=dy/dx;
            if (obj.slope ~= Inf)
                interumx = round(x0in + .5*(dx));
                interumy =round(y0in + .5*(dy)-5);
                if (dx > 0)
                    if(img(interumy,interumx)>(80))
                        invert = 0;
                    else
                        invert = 1;
                    end
                else
                    if(img(interumy,interumx)<(80))
                        invert = 1;
                    else
                        invert = 0;
                    end
                end
            else%should ensure the left is always white looking from xoyo
                interumx = round(x0in + .5*(x1in-x0in)-5);
                interumy = round(y0in + .5*(y1in-y0in));
                if (dy > 0)
                    if(img(interumy,interumx)<(80))
                            invert = 0;
                    else
                            invert = 1;
                    end
                else
                    if(img(interumy,interumx)>(80))
                        invert = 1;
                    else
                        invert = 0;
                    end
                end
            end
            if (invert == 0)
                obj.x0=x0in;
                obj.y0=y0in;
                obj.x1=x1in;
                obj.y1=y1in;
            else
                obj.x0=x1in;
                obj.y0=y1in;
                obj.x1=x0in;
                obj.y1=y0in;
            end
        end
    end
end
   
   