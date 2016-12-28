
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Title:  FLIR GRANNY CAM- POC EMS                                              %
% Author:  Dr. Ioannis Kypraios                                                         %
% Date Created: 20.12.16                                                                %
% Edited:       22.12.16                                                                %
% Summary:      tiff Read                                                               %
%                                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;

%Extract the number of frames from the tiff file's information. The
%number of columns in structure is equal to the number of frames. 

imageInfo=imfinfo('test.tiff');

numFrames=length(imageInfo);

%Pre-size the movie matrix
imSize=[imageInfo(1).Height,imageInfo(1).Width,numFrames];
myMovie=ones(zeros(imSize));

for frame=1:numFrames
  imageStack(:,:,frame)=imread('test.tiff',frame);
end