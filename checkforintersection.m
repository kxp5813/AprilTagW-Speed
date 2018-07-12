function [inter,found] = checkforintersection(seg1, seg2)
%feeds in line segments to search for intersections
frontendlocality = abs(seg1.x0-seg2.x1)+abs(seg1.y0-seg2.y1); 
    if (frontendlocality <12 && seg2.doubleline == 0)
        backendlocality = intersection(seg1,seg2);
        backenddiff = abs(backendlocality.line1endx-backendlocality.line2endx)+...
            abs(backendlocality.line1endy-backendlocality.line2endy);       
        if (backenddiff>25)%prevents two parallel lines that are really similar from being intersections
            inter = intersection(seg1,seg2);
            found = 1;
        else
            inter = 0;
            found = 0;
        end
    else
        inter = 0;
        found = 0;
    end   
end