firstfewsteps();

arrayofindexes = 1;%keeps track of numbers in each bin
t=1;
twodarrayofedges{1,1}=edgel(1);
%each bin ought to hold a group of edges of similar hefts
%they will later be sorted based on location
%and then based upon cost difference(heft)
for ind=2:length(edgel)
    listexists = 0;
    matches = 0;
    for g=1:t%check if bin already exists
        if (edgel(ind).heft <=(twodarrayofedges{g,1}.heft + 5) &&...
                edgel(ind).heft>=(twodarrayofedges{g,1}.heft -5) && matches == 0)
            listexists = g;%finds the row it should belong
            v = listexists;
            closeness = 1;
            break;
        end
    end
    if listexists ~= 0%already exists, add to it
        arrayofindexes(v)=arrayofindexes(v)+1;
        m = arrayofindexes(v);
        interumgradedge = edgel(ind);
        twodarrayofedges{v,m}=interumgradedge;
    end    
    if (listexists == 0)%cost does not exist or isnt close enough
        t=t+1;
        twodarrayofedges{t,1}=edgel(ind);
        arrayofindexes(t)=1;
    end
end





    
