%weightseperation
function d = recursivesort(node,nodenum,array,index)%base case should be node is head
%node becomes attached to head otherwise, go deep kids
    test=node.pixela;
    previousweight = node.heft;
    for i=nodenum:length(array)
        checkval = array(i).pixela;
        currentweight = array(i).heft;
        if (checkval(1) >= test(1) -1 && checkval(1) <= test(1)+ 1 &&...
              checkval(2) >= test(2) -1 && checkval(2) <= test(2)+ 1 && ...
                    currentweight > previousweight + .05 || currentweight < previousweight - .05)
                recursivesort(array(i), i, array,index+1);
                array(i)=[];
                break;
        end
    end
    d(index) = array(i);
end