%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Title:  FLIR GRANNY CAM- POC EMS                                              %
% Author:  Dr. Ioannis Kypraios                                                         %
% Date Created: 23.12.16                                                                %
% Edited:       24.12.16                                                                %
% Summary:      BG Segmentation                                                         %
%                                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;

%Reading the reference frame 
refback = imread('testBG.bmp');

framesample = 1;

%Reading the images from video
video = aviread('50_36.avi',1:framesample:44)

num_frames = length(video);

% c1 = [60 460 460 60];
% r1 =[94 94 110 110];
% 
% c2 = [60 460 460 60];
% r2 =[410 410 446 446];

prev_sum_img = 12;


% Making a video object
%aviobj1 =  avifile('output.avi','Fps',6);
%Resizing the video to the desired dimensions
frame_count = 1;
for f = 1:num_frames;
video(f).cdata = imresize(video(f).cdata, [160 160],'bilinear');
  orig_vid = rgb2gray(video(f).cdata);
%Subtracting the original frame from the reference frame   
Y = abs(im2double(orig_vid) - im2double(refback));

 %Y = roifill(Y,c1,r1);
 %Y = roifill(Y,c2,r2);
 
%Drawing mask
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
% % % %Thresholding the remaining image 
 max_val = max(max(Y));
 Y = Y > max_val;
 Y = double(Y);

 
 Y(x1:x1+20,y1:y1+20) = sub_image(:,:);
Y(x1:x1+20,y1) = 200;
Y(x1,y1:y1+20) = 200;
Y(x1:x1+20,y1+20) = 200;
Y(x1+20,y1:y1+20) = 200;

% % 

imshow(Y);
%aviobj1 =  addframe(aviobj1,Y);
frame_count = frame_count + 1;
end;
%aviobj1 = close(aviobj1); 