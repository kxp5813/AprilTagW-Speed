%goal is to fine intersections and angles, then check for (n-2)*180 angle
%measure, then check number of shapes and their respective edges to known
%tags, once the shapes have been identified, the largest square (n=4)
%should be the tag

classdef intersection
    properties
        line1endx
        line1endy
        line2endx
        line2endy
        length
    end
    methods
        %we know that at point x0y0 facing x1y1 white is on the left, so we
        %can reject any pairings that would force a white to white
        %interface
       function obj = intersection(lineseg1, lineseg2)
           obj.line1endx = lineseg1.x1;
           obj.line1endy = lineseg1.y1;
           obj.line2endx = lineseg2.x0;
           obj.line2endy = lineseg2.y0;
           obj.length = lineseg1.length + lineseg2.length;
           
        end
    end
end
