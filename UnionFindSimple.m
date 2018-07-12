classdef UnionFindSimple
    properties
        data = struct('id', 1, 'size', 1)
        
    end
    methods
        function obj = UnionFindSimple(maxID)
            for i=1:maxID
                data(i).id = i;
                data(i).size = 1;
            end
        end
        function result = getRepresentative(thisid)
            if (data(thisid).id == thisid)
                result = thisid
                return;
            else
                root = getRepresentative(data(thisid).id)
            end
            data(thisid).id = root
            result = root;
            return;
        end
        function node = connectNodes(aid, bid)
            aRoot = getRepresentative(aid);
            bRoot = getRepresentative(bid);
            
            if (aRoot == bRoot)
                node = aRoot
                return;
            end
            asz = data(aRoot).size;
            bsz = data(bRoot).size;
            
            if(asz>bsz)
                data(bRoot).id = aRoot;
                data(bRoot).size = bsz +data(bRoot).size;
                node = aRoot;
                return;
            else
                data(aRoot).id = bRoot;
                data(bRoot).size = asz+data(bRoot).size;
                node = bRoot;
                return;
            end
        end
        
    end
end

    