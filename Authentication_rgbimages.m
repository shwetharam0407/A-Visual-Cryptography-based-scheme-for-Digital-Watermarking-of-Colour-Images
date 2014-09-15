clear;
clc;
img=imread('baboon.jpg');
%img=imread('baboonquality1.jpg'); % reads the test image
imshare1= img(:,:,1); % test image split into three shares
imshare2= img(:,:,2); % according to colour stream
imshare3= img(:,:,3);
v= imread('rgbsecretim.png'); % reads verification image
v1= im2bw(v(:,:,1)); % generates verification information
v2= im2bw(v(:,:,2));
v3= im2bw(v(:,:,3));
seed = input('Enter pass key: '); % reads secret pass key
w1= wgen(imshare1, v1, seed); % generates the test watermark
w2= wgen(imshare2, v2, seed);
w3= wgen(imshare3, v3, seed);
w_fin = w1 +w2 + w3; % final test watermark
figure(2)
subplot(1,2,1)
imshow(w_fin); % displays test watermark
title('Test watermark')
subplot(1,2,2)
%imshow('customwmk1.png'); % displays original watermark
imshow('chinese-character.png')
title('Original watermark')
