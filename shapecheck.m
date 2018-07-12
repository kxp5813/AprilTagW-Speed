%extrashapedeletion
index = 1;
for i=1:length(listofintersections)
    if (~isempty(listofintersections(i)))
        med=listofintersections(i);
        for t=(i+1):length(listofintersections)
            if (~isempty(listofintersections(t)))
                check=listofintersections(t);
                checkval=abs(med.line1endx-check.line1endx)+abs(med.line1endy-check.line1endy)+...
                    abs(med.line2endx-check.line2endx)+abs(med.line2endy-check.line2endy);
                reversecheckval=abs(med.line1endx-check.line2endx)+abs(med.line1endy-check.line2endy)+...
                    abs(med.line2endx-check.line1endx)+abs(med.line2endy-check.line1endy);  
                if (checkval <12 || reversecheckval<12 || t == i)
                    
                else
                    listofinteractions2{index} = listofintersections(i);
                    index = index+1;
                end
            end
        end
    end
end

