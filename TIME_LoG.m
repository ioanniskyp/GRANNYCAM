
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Title:  FLIR GRANNY CAM- POC EMS                                              %
% Author:  Dr. Ioannis Kypraios                                                         %
% Date Created: 23.12.16                                                                %
% Edited:       23.12.16                                                                %
% Summary:      LoG                                                                     %
%                                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;
load rem2_inter_3

refback = zeros(size(vid(2).cdata)); 

l_vid = length(vid) - 1;
 for f =  1 : l_vid
 Imgfft =im2double(vid(f).cdata);
 [siz1,siz2] = size(Imgfft);
 
 siz1;
 siz2;
 
 SpatDog = fspecial('log',siz1,1.6);
 FreqDog = im2double(SpatDog);
 multip = abs(FreqDog).*(Imgfft);
 %Y = isfft(multip);
 
 refback = refback + im2double(multip);
 
 end;
 refback = (1/l_vid) * refback;

%imshow(refback);
 %     pause;

framesample = 1;

%Reading the images from videos
video = aviread('50_36.avi',1:framesample:44)

num_frames = length(video);


%Resizing 
frame_count = 1;
for f = 1:num_frames;
video(f).cdata = imresize(video(f).cdata, [160 160],'bilinear');
%Applying the LoG
Imgfft = im2double((rgb2gray(video(f).cdata)));
[siz1,siz2] = size(Imgfft);
siz1;
siz2;
SpatDog = fspecial('log',siz1,1.6);
FreqDog = im2double(SpatDog);
multip = (abs(FreqDog).*(Imgfft));
%Subtracting the original frame from the reference frame   
c = im2double(refback) - im2double(multip);
 video(f).cdata = (c);
imshow(video(f).cdata);
      pause;
end;




% % 
% % %Integrating the subset image to the original image
% Y(x1:x1+20,y1:y1+20) = sub_image(:,:);
% 
% Y(x1:x1+20,y1) = 200;
% Y(x1,y1:y1+20) = 200;
% Y(x1:x1+20,y1+20) = 200;
% Y(x1+20,y1:y1+20) = 200;
% imshow(Y);
% 
% pause;
% %aviobj1 =  addframe(aviobj1,Y);
% 
% frame_count = frame_count + 1;
% end;
% %aviobj1 = close(aviobj1); 