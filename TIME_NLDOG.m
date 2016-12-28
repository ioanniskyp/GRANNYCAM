
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Title:  FLIR GRANNY CAM- POC EMS                                              %
% Author:  Dr. Ioannis Kypraios                                                         %
% Date Created: 20.12.16                                                                %
% Edited:       22.12.16                                                                %
% Summary:      TIME NL-DOG                                                             %
%                                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;

load rem2_inter_1
NL = 5;
refback = zeros(size(vid(2).cdata)); 

l_vid = length(vid) - 1;
 for f =  1 : l_vid
 Imgfft = sfft(vid(f).cdata);
 [siz1,siz2] = size(Imgfft);
 
 siz1;
 siz2;
 
 SpatDog = fspecial('gaussian',siz1,0.15) - fspecial('gaussian',siz2,0.49);
 FreqDog = sfft(SpatDog);
 multip = abs(FreqDog).*Imgfft;
 Y = isfft(multip);
 % Non-linear application applied on top of the DOG filter
Z = (sigmf(Y, [NL 0])*2)-1;
Z = real(Z);

 refback = refback + im2double(Z);
 
 end;
 refback = (1/l_vid) * refback;


framesample = 1;

%Reading the images from videos
video = aviread('50_bsize_36.avi',1:framesample:44)

num_frames = length(video);

prev_sum_img = 12;

 
%Resizing 
frame_count = 1;
for f = 1:num_frames;
video(f).cdata = imresize(video(f).cdata, [540 540],'bilinear');
%Applying the NL-DOG 
Imgfft = sfft(rgb2gray(video(f).cdata));
[siz1,siz2] = size(Imgfft);
siz1;
siz2;
SpatDog = fspecial('gaussian',siz1,0.15) - fspecial('gaussian',siz2,0.49);
FreqDog = sfft(SpatDog);
multip = (abs(FreqDog).*Imgfft);
%Taking the Inverse FFT of the original video
Y2 = isfft(multip);
 % Non-linear application applied on top of the DOG filter
Z = (sigmf(Y2, [NL 0])*2)-1;
Z = real(Z);

%Subtracting the original frame from the reference frame in frequency domain  
Y = im2double(refback) - im2double(Z);
%Y = roifill(spatdif,c,r);
%Y2 = Y;

max_values = max(Y);
max_sort = sort(max_values,'descend');

sum_img = 0;

i = 1;

if frame_count <= 1
  while (sum_img < 11)
temp = max_sort(i);
[x,y] = find(Y == temp);

y1 = y - 10;  
x1 = x - 10;

if (y1 < 1)
    y1 = 1;
end;
sub_image(:,:) = Y(x1:x1+20,y1:y1+20);
sub_img = sub_image(:,:) > 0.02;  
sum_img = sum(sum(sub_img));
i = i + 1;
   end; 
else
    count = 1; 
    while(count < 300)
         temp = max_sort(i);
       [x,y] = find(Y == temp);
 
     y1 = y - 10;  
     x1 = x - 10;

if y1 < 1
    y1 = 1;
end;
if y1 > 519
    y1 = 517;
end;
sub_image(:,:) = Y(x1:x1+20,y1:y1+20);
     tmp = im2double(sub_image) - im2double(prev_sub_img); 
    for k = 1: 21
        for j = 1: 21
           if tmp(k,j)> 0
              count = count + 1;
           end;
        end;
    end;
        i = i + 1;
    end;
end;

prev_sub_img = sub_image; 

 sub_image(:,:) = Y(x1:x1+20,y1:y1+20);
 %Thresholding the remaining image to the for the 10 largest values.
 max_val = max(max(Y));
 Y = Y > max_val;
 Y = double(Y);
% %Taking the DOG of the subset image
% %dog_sub_image = edge(sub_image,'canny'); 
% %dog_sub_image = ZOG(sub_image,0.73,0.633);
% 
% %Integrating the subset image to the original image
Y(x1:x1+20,y1:y1+20) = sub_image(:,:);

Y(x1:x1+20,y1) = 200;
Y(x1,y1:y1+20) = 200;
Y(x1:x1+20,y1+20) = 200;
Y(x1+20,y1:y1+20) = 200;




imshow(Y);
%aviobj1 =  addframe(aviobj1,Y);
pause;
frame_count = frame_count + 1;
end;
%aviobj1 = close(aviobj1); 