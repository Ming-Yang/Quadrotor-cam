clear;clc;

I=imread('(2)L.jpg');
I=rgb2gray(I);
subplot(2,3,1);
imshow(I,[]);
title('Original Image');

sobelBW=edge(I,'sobel');
%figure;
subplot(2,3,2);
imshow(sobelBW);
title('Sobel Edge');

robertsBW=edge(I,'roberts');
%figure;
subplot(2,3,3);
imshow(robertsBW);
title('Roberts Edge');

prewittBW=edge(I,'prewitt');
%figure;
subplot(2,3,4);
imshow(prewittBW);
title('Prewitt Edge');

logBW=edge(I,'log');
%figure;
subplot(2,3,5);
imshow(logBW);
title('Laplasian of Gaussian Edge');

cannyBW=edge(I,'canny');
%figure;
subplot(2,3,6);
imshow(cannyBW);
title('Canny Edge');