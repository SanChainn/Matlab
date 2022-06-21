
load all_data.mat all_data
data1= all_data(4,1:23232);               %read one row of data 200 x 23232
img1= reshape(data1, [176,132]);            %reshape to 176 x 132 
img2 = zeros(176,132,'uint8');              %create zero array 176 x 132 uint8

img2(img1<=1.8) = 255;                      %mask  255 and 0 to img2(zero array) if img1<=1.8

img3 = bwareaopen(img2,5000);               %remove small object for ROI region of interest cow
stats= regionprops(img3);                   %get stats of img3 eg. [Area , Centroid , Bounding Box]
if size(stats,1)>=1     
crp_img = imcrop(img1, stats.BoundingBox)'; %get depth value region from (img1 - bounding box region)


crp_img_surf = 3.3 - crp_img;
surf(crp_img_surf)


crp_img2 = imcrop(img2, stats.BoundingBox)';%crop ROI of cow bounding box region 80 x 176 

back_bone = crp_img(40,21:176)';            %creat back_bone region of depth value cow image
figure,imshow(crp_img2)                     
hold on
scatter(21:176,ones(1,156)*40,"r.")         %scatter line and points
hold off;
max_val = max(back_bone);                   %find max value of back bone depth cow

back_bone1 = abs(back_bone-max_val);        %absolute value 
    
figure,plot(1:156,back_bone1);              %plot cow depth value curve U shape
ylim([0 1])
back_bone2 = smooth(back_bone1,10) ;        %smooth plot
figure,plot(1:156,back_bone2);
ylim([0 1])
end
