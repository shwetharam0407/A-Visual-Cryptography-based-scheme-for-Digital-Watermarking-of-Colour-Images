%__________________________________________________________________________
% The following code implements our scheme for Digital Watermarking of rgb
% images making use of visual cryptography techniques.
% In this scheme the watermark is split into three shares such that the
% logical addition of all three gives back the watermark.
% The rgb image to be marked is also condensed into colour-corresponding three
% streams. Using the three watermark shares respectively for each image stream yields
% three verification matrices which are stored in a single rgb secret
% verification image.
%__________________________________________________________________________
clear;
clc;
img = imread('baboon.jpg'); % reads the image to be marked
%wmark =im2bw(imread('customwmk1.png')); % reads the original watermark in binary
wmark = im2bw(imread('chinese-character.png'));
[rows, cols] = size(wmark);
mat = randperm(rows*cols); % generates a random array
m_a = mat(1, 1: cast(rows*cols/3, 'int64')); % generates three arrays each comprising
m_b = mat(1, cast(rows*cols/3, 'int64') : cast(2*rows*cols/3, 'int64')); % a third of the elements in random array
m_c = mat(1, cast(2*rows*cols/3, 'int64'):end);
wshare1= zeros(rows, cols); % initializes the three shares of the watermark
wshare2= zeros(rows, cols);
wshare3= zeros(rows, cols);
for i=1:size(m_a ,2) % the pixels from the watermark are now stored in the three shares
index= m_a(i); % such that on logically adding all three the watermark can
wshare1(index)= wmark(index) ; % be exactly recovered
end
for i=1:size(m_b ,2)
index= m_b(i);
wshare2(index)= wmark(index) ;
end
for i=1:size(m_c ,2)
index= m_c(i);
wshare3(index)= wmark(index) ;
end
imshare1= img(:,:,1); % generates three shares of image to be marked
imshare2= img(:,:,2); % by splitting its streams
imshare3= img(:,:,3);
seed = input('Enter passkey: '); % accepts secret pass key from user
v1 = vgen(imshare1, wshare1 , seed); % generates verification information
v2 = vgen(imshare2, wshare2 , seed);
v3 = vgen(imshare3, wshare3 , seed);
v_fin(:,:,1)= v1; % all verification image is stored
v_fin(:,:,2)= v2; % in a single rgb image
v_fin(:,:,3)= v3;
disp('The secret information to be stored with the neutral authority is ')
figure(1)
subplot(2,2,1)
imshow(wshare1)
title('watermark share 1')
subplot(2,2,2)
imshow(wshare2)
title('watermark share 2')
subplot(2,2,3)
imshow(wshare3)
title('watermark share 3')
subplot(2,2,4)
imshow(wmark)
title('watermark');
figure(2)
imshow(v_fin);
title('Verification information')
imwrite(v_fin, 'rgbsecretim.png');
