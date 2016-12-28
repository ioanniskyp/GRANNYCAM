%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Title:  GRANNY CAM- POC EMS                                                   %
% Author:  Dr. Ioannis Kypraios                                                         %
% Date Created: 19.12.16                                                                %
% Edited:                                                                               %
% Summary:                                                                              %
%                                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,y,sub_image] = mask_match(Y)

max_values = max(Y);
max_sort = sort(max_values,'descend');
i = 1;
sum_img = 1;   

while(sum_img < 11)      
   temp = max_sort(i);
       [x,y] = find(Y == temp,1);
 
     y1 = y - 10; 
     x1 = x - 10;

if y1 < 1
    y1 = 1;
end;
if y1 > 519
    y1 = 517;
end;
sub_image(:,:) = Y(x1:x1+20,y1:y1+20);
     sub_img = sub_image(:,:) > 0.02;  
     sum_img = sum(sum(sub_img));
  i = i + 1;
  end;
 
  
  return;