mergeedges();
nodenum=1;
rows = 1;
endofindex = length(arrayofindexes);
order{1,1}=twodarrayofedges{1,1};
for runcheck = 1:length(arrayofindexes)%searches row by row
    nodenum = 1;
    firstrun = 1;
    for indexer= 1:arrayofindexes(runcheck)-1%searches across a given row
        if (~isempty(twodarrayofedges{runcheck,indexer}))
            nodenum = 1;
            test = twodarrayofedges{runcheck,indexer}.pixela;              
            for interior = indexer:arrayofindexes(runcheck)-1%checks from indexer position to end of row
                if (~isempty(twodarrayofedges{runcheck,interior}))
                    %need to implement a deltap function, because we keep
                    %running into  two lines smushed into a single line
                    checkval = twodarrayofedges{runcheck,interior}.pixela;
                    pixeldeltap(1)= test(1)-checkval(1);
                    pixeldeltap(2)= test(2)-checkval(2);
                    if (checkval(1) >= test(1) -1 && checkval(1) <= test(1)+ 1 &&...
                            checkval(2) >= test(2) -1 && checkval(2) <= test(2)+ 1)
                        %checks for adjacent pixela's, non adjacent dont get added
                        %has to have at least one adjacent to be considered
                        if (firstrun ==1)
                                order{rows,nodenum}=twodarrayofedges{runcheck,indexer};
                                order{rows,nodenum}.source = rows;
                                order{rows,nodenum}.heft = pixeldeltap;
                                firstrun = 0;
                                nodenum = nodenum +1;
                        end
                            order{rows,nodenum}= twodarrayofedges{runcheck,interior};
                            order{rows,nodenum}.source = rows;
                            test = twodarrayofedges{runcheck,interior}.pixela;
                            twodarrayofedges{runcheck,interior}=[];%once used, is removed
                            %removal of already used values ought to speed up
                            %execution
                            nodenum = nodenum +1;
                    end
                end
            end
            if (firstrun ~= 1 && nodenum >12)%only edges of 12 or more exist
                arrayofsortedindexes(rows)=nodenum-1;
                rows = rows +1;
                firstrun = 1;
            end
        end
    end
end


[slopesort, arrayofindexes] = sorter(order,arrayofsortedindexes);

%need to figure out a way to run through the list already sorted based upon
%heft and locality, and then sort based on cost, potentially by tracking
%source?

% rowsbasedonheftandlocality = rows;

% for runcheck = 1:length(arrayofsortedindexes)
%     for indexer= 1:arrayofsortedindexes(runcheck)-1
%         if (~isempty(order{runcheck,indexer+1}))
%             deltacost=abs(order{runcheck,1}.cost-order{runcheck,indexer+1}.cost);
%             nodenum = 1;
%             if deltacost > 10
%                 existsflag = 0;
%                 for remainder=indexer:(length(arrayofsortedindexes)-1)
%                     if (order{runcheck,indexer+1}.source == order{remainder,1}.source &&...
%                             (abs(order{runcheck,indexer+1}.cost-order{remainder,1}.cost) < 15))
%                         %runs through list checking first index for source
%                         %match
%                         existsflag = 1;
%                         where = remainder;
%                         break;
%                     end
%                 end
%                 if (existsflag ==1)
%                     arrayofsortedindexes(where)=arrayofsortedindexes(where)+1;
%                     order{where,arrayofsortedindexes(where)}=order{runcheck,indexer+1};
%                 else
%                     arrayofsortedindexes(runcheck)=indexer;
%                     rows=rows+1;
%                     interum = order{runcheck,(indexer+1)};
%                     order{rows,1} =interum;
%                     nodenum = nodenum +1;
%                     arrayofsortedindexes(rows) = nodenum;
%                 end%empties to prevent double indexing
%                 order{runcheck,indexer+1} = [];
%              end
%                 arrayofsortedindexes(rows) = nodenum;
%          end
%      end
% end
%         
% for runcheck = 1:length(arrayofsortedindexes)
%     rownum = 1;
%     for indexer= 1:arrayofsortedindexes(runcheck)-1
%         if ~isempty(order{runcheck,indexer})
%             orderedcost{runcheck,rownum} = order{runcheck,indexer};
%             rownum = rownum+1;
%         end
%     end
%     arrayofcostsorted(runcheck)=rownum-1;
% end

        
        
        
        
        
        
