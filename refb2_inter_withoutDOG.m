%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Title:  FLIR GRANNY CAM- POC EMS                                              %
% Author:  Dr. Ioannis Kypraios                                                         %
% Date Created: 17.12.16                                                                %
% Edited:       20.12.16                                                                %
% Summary:      Generate the reference frame based on TIME                              %
%                                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%vid = aviread('filenameInput.avi')

refback = zeros(size(vid(2).cdata)); 

 for f =  1 : 8
    Y = vid(f).cdata; 
 
 refback = refback + im2double(Y);
 end;
 refback = (1/8) * refback;
 
 imshow(refback)
 imwrite(refback,'filename_.bmp');
