%quicktest
figure;
imshow(grad);
title('corners n such');
hold on;
for i = 1:length(listoflines)
    plot(listoflines(i).x0,listoflines(i).y0);
    %plot(listoflines(i).x1,listoflines(i).y1, 'b*');
end 
hold off;