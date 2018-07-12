segmenter();
rsum = 0;
exx = 0;
eyy = 0;
interumxend = 0;
interumyend = 0;
interumxstart = 0;
interumystart = 0;
divisor = 1;
index=1;
for i=1:length(arrayofindexes)-1
    x=zeros;
    y=zeros;
    if (arrayofindexes(i) > 10 )
        rsum = 0;
        exx = 0;
        eyy = 0;
        xhat=mean(slopesort{i}.pixela(2));
        yhat=mean(slopesort{i}.pixela(1));
        for m=1:arrayofindexes(i)-1
            x(m)=slopesort{i,m}.pixela(2);
            y(m)=slopesort{i,m}.pixela(1);
            rsum =rsum+(x(m)-xhat)*(y(m)-yhat);
            exx = exx+(x(m)-xhat)^2;
            eyy = eyy+(y(m)-yhat)^2;
        end
%regressing
        slopecheckx1 = abs(slopesort{i,1}.pixela(2)-slopesort{i,arrayofindexes(i)}.pixela(2));
        slopechecky1 = abs(slopesort{i,1}.pixela(1)-slopesort{i,arrayofindexes(i)}.pixela(1));
        slopecheck1  = round(slopechecky1/slopecheckx1);
        %checks the slope of the first line group in slopesort to match local
        %slope matching lines
        for u=(i+1):length(arrayofindexes)-1
            if arrayofindexes(u) ~= 0
                startlocality = abs(slopesort{i,1}.pixela(2)-slopesort{u,1}.pixela(2))...
                    +abs(slopesort{i,1}.pixela(1)-slopesort{u,1}.pixela(1));
                endlocality=abs(slopesort{i,arrayofindexes(i)}.pixela(2)-slopesort{u,arrayofindexes(u)}.pixela(2))...
                    +abs(slopesort{i,arrayofindexes(i)}.pixela(1)-slopesort{u,arrayofindexes(u)}.pixela(1));
                slopecheckx2 = abs(slopesort{u,1}.pixela(2)-slopesort{u,arrayofindexes(u)}.pixela(2));
                slopechecky2 = abs(slopesort{u,1}.pixela(1)-slopesort{u,arrayofindexes(u)}.pixela(1));
                slopecheck2  = round(slopechecky2/slopecheckx2);
                %provided non-empty list, checks for a similar start or end
                %and the same slope
                uxhat = mean(slopesort{u}.pixela(2));
                uyhat = mean(slopesort{u}.pixela(1));
                if (slopecheck1==slopecheck2 && (startlocality <9 || endlocality <9))
                    interumxend = interumxend+slopesort{u,arrayofindexes(u)}.pixela(2);
                    interumyend = interumyend+slopesort{u,arrayofindexes(u)}.pixela(1);
                    interumxstart = interumxstart+slopesort{u,1}.pixela(2);
                    interumystart = interumystart+slopesort{u,1}.pixela(1);
                    for b=1:arrayofindexes(u)
                        x(m+b)=slopesort{u,b}.pixela(2);
                        y(m+b)=slopesort{u,b}.pixela(1);
                        rsum =rsum+(x(m+b)-uxhat)*(y(m+b)-uyhat);
                        exx = exx+(x(m+b)-uxhat)^2;
                        eyy = eyy+(y(m+b)-uyhat)^2;
                    end
                    divisor = divisor +1;
                    m=m+b;
                    %update incase of more than two coming together
                    arrayofindexes(u) = 0;
                end
            end
        end 

        rdivisor=(exx*eyy)^(.5);    
        r=rsum/rdivisor;
        sysx= std(y)/std(x);    
        slope = r*sysx;
        yintercept= yhat -slope*xhat;
        x0 = round((interumxstart+slopesort{i,1}.pixela(2))/divisor);
        y0 = round((interumystart+slopesort{i,1}.pixela(1))/divisor);
        x1 = round((interumxend +slopesort{i,arrayofindexes(i)}.pixela(2))/divisor);
        y1 = round((interumyend +slopesort{i,arrayofindexes(i)}.pixela(1))/divisor);


         x0 = slopesort{i , 1}.pixela(2);
         y0 = slopesort{i , 1}.pixela(1);
         x1 = slopesort{i , arrayofindexes(i)-1}.pixela(2);
         y1 = slopesort{i , arrayofindexes(i)-1}.pixela(1);

        listoflines(index)=GlineSeg(x0,y0,x1,y1);
        index = index+1;
    end
end

indexer = 1;
for i= 1:length(listoflines)
    seg1=listoflines(i);
    %reset the doubleline for potential use later
    for b=1:length(listoflines)
        listoflines(b).doubleline = 0;
    end
    for median = 1:length(listoflines)
        seg2=listoflines(median);
        [inter,worked]=checkforintersection(seg1,seg2);
        if (worked == 1)
            listofintersections(indexer)=inter;
            indexer = indexer+1;
        end
    end
end

l = 1;
s = 1;
for i = 1:length(listofintersections)
     start=listofintersections(i);
     for m = 1:length(listofintersections)
        middle=listofintersections(m);
        frontenddiff = abs(start.line1endx-middle.line2endx)+...
                    abs(start.line1endy-middle.line2endy);
        backenddiff = abs(start.line2endx-middle.line1endx)+...
                    abs(start.line2endy-middle.line1endy);
        if(i ~= m && frontenddiff <12 && backenddiff <12)%completes quads
            quad{l,1}=start;
            quad{l,2}=middle;
            l = l+1;
        elseif(i~=m && frontenddiff <12)
            shape{s} = GlineSeg(start.line2endx,start.line2endy,middle.line1endx,...
                middle.line1endy);
            s=s+1;
        elseif(i~=m && backenddiff <12)%creates shapes
            shape{s} = GlineSeg(start.line1endx,start.line1endy,middle.line2endx,...
                middle.line2endy);
            s=s+1;
        end            
     end
end


