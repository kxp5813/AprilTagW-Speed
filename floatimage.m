classdef floatimage
    properties
        width
        height
        pixels
    end
    methods
        %constructor for floatimage
        function obj = floatimage(filename)
            img = imread(filename);
            imgg=rgb2gray(img);
            figure; imshow(imgg)
            b = fspecial('Gaussian',3,.5);
            c = imgaussfilt(imgg);%works but also works through fspecial
            x = imfilter(imgg, b, 'conv');%does not work through conv2
            [G1,G2]=gradient(double(x));
            figure('Name','filtered'); imshow(x)
            figure('Name','horizontal gradient'); imshow(G1)
            figure('Name','vertical gradient'); imshow(G2)
            mags=(G1.^2 +G2.^2).^(.5);
            dir=atan2(G2,G1);%this system does a very mediocre job compared to the built in
            figure('Name','magnitude'); imshow(mags)%imgradient function
            figure('Name','direction'); imshow(dir)
            d = size(x)
            obj.height = d(1)
            obj.width = d(2)
            obj.pixels = 2,0:(obj.height*obj.width);
            for i=1:obj.height
                for j=1:obj.width
                    obj.pixels(1,((i-1)*obj.width+obj.width))=(dir(i,j));
                    obj.pixels(2,((i-1)*obj.width+obj.width))=c(i,j);
                end
            end
            %assignin('base',c,c)
        end
        
        function decimateAvg(image)
            nheight = image.height/2
            nwidth = image.width/2
            for y=1:nheight
                for x = 1:nwidth
                    image.pixels((y-1)*nwidth+x) = image.pixels((2*(y-1))*width+(2*x))
                end
            end
            image.width = nwidth
            image.height = nheight
            image.pixels(nwidth*nheight:image.width*image.height) = []
        end
        
        function normalize(obj)
            maxVal = max(obj.pixels(2,: ))
            minVal = min(obj.pixels(2,:))
            range = maxVal -minVal
            rescale = 1/range
            for i = 1:length(obj.pixels)
                obj.pixels(2,i) = (obj.pixels(2,i)-minVal) *rescale;
            end
        end
        
        function filterfactoredcentered(obj, fhoriz, fvert)
            r(obj.pixels)
            for y =0:obj.height
                convolve(obj.pixels, y*obj.width,obj.width,fhoriz,r,y*obj.width)
            end            
            tmp(obj.height)
            tmp2(obj.height)
            for x =0:obj.width
                for y =0:obj.height
                    tmp(y)=r(y*obj.width + x)
                    
                    convolve(tmp, 0, obj.height, fvert, tmp2, 0)
                end
                for y = 0:obj.height
                    obj.pixels(y*obj.width + x) = tmp(y)
                end
            end
        end
        
        function printminmax(obj)
            sprintf("Min: ", min(obj.pixels)," Max: ",max(obj.pixels))
        end
    end
end
    
            
        
        
                