function [list, indexes] = sorter(incoming,incomingindexarray)
    delta = 1;
    x = length(incomingindexarray);
    while delta ~= 0
        delta = 0;%flag indicator of change
        for i=1:length(incomingindexarray)
            previouspixel=incoming{i,1};%first run artifact
            slopesort{i,1}=incoming{i,1};
            if incomingindexarray(i)>2
                for t = 2:incomingindexarray(i)
                    pixeldeltap = incoming{i,t};
                    n = 1;
                    if (t>2 &&(pixeldeltap.heft ~= previouspixel.heft))
                        %suddenslopechange
                        for h=(t):incomingindexarray(i)
                            slopesort{x,n}=incoming{i,h};
                            n=n+1;
                            %delta = 1;
                        end
                        slopesortedindexes(x)=n-1;
                        x=x+1;
                        break;
                    else
                        slopesort{i,t}=incoming{i,t};
                    end
                    previouspixel = pixeldeltap;
                end
                slopesortedindexes(i)=t-1;
            end
        end
    end
    list = slopesort;
    indexes = slopesortedindexes;
end
    