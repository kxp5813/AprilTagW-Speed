%first few steps
%obj = floatimage('tag_middle.png')
%normalize(obj)
img = imread('tag_middle.png');
b = fspecial('Gaussian',3,.5);
imfilt = imfilter(img, b, 'conv');
img = rgb2gray(imfilt);               
[gmag,grad]=imgradient(img,'prewitt');
%although floatimage works it was mediocre compared to the built in
%function for imgradient

grad = imgaussfilt(grad);
figure
imshowpair(gmag, grad, 'montage');
title('Magnitude and Direction')

%rescales
maxVal1 = max(gmag(:,:));
maxVal = max(maxVal1);
minVal1 = min(gmag(:,:));
minVal = min(minVal1);
range = maxVal -minVal;
rescale = 1/range;
d = size(gmag);
for i = 1:d(1)
    for j=1:d(2)    
     gmag(i,j) = (gmag(i,j)-minVal) *rescale;
    end
end

%Thresholds
for i = 1:d(1)
    for j=1:d(2)
        if (gmag(i,j)<.04)
            gmag(i,j)=0;
        end
    end
end


nEdges = 1;
for x=35:(d(1)-30)
    for y=35:(d(2)-30)
        if (gmag(x,y)~=0)
            %horizontal
            if (gmag(x+1,y)~=0)
                cost1=gradedges.edgecost(grad(x,y),grad(x+1,y));
                if (cost1 >=0)
                    edgel(nEdges) = gradedges(cost1,[x,y],img(x,y),[x+1,y]);
                    nEdges = nEdges+1;
                end
            end
            %vertical
            if (gmag(x,y+1)~=0)
                cost2=gradedges.edgecost(grad(x,y),grad(x,y+1));
                if (cost2 >=0)
                    edgel(nEdges) = gradedges(cost2,[x,y],img(x,y),[x,y+1]);
                    nEdges = nEdges+1;
                end
            end    
            if (gmag(x+1,y+1)~=0)
            %downward diagonal edge
                cost3=gradedges.edgecost(grad(x,y),grad(x+1,y+1));
                if (cost3 >=0)
                    edgel(nEdges) = gradedges(cost3,[x,y],img(x,y),[x+1,y+1]);
                    nEdges = nEdges+1;
                end
            end    
            if (gmag(x-1,y+1)~=0)
            %upward diagonal edge
                cost4=gradedges.edgecost(grad(x,y),grad((x-1),(y+1)));
                if (cost4 >=0)
                    edgel(nEdges) = gradedges(cost4,[x,y],img(x,y),[x-1,y+1]);
                    nEdges = nEdges+1;
                end
            end
        end
    end
end
% 
% figure;
% imshow(grad);
% title('W/edges');
% hold on;
% for i = 1:length(edgel)
%     plot(edgel(i).pixela(2),edgel(i).pixela(1), 'r*')
% end
% hold off;








        