
% testing program for function cluster_binary mask
clc;clear;

addpath('C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\K Mean\G6\Threshod 4')
addpath('C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab')

% reading Mat dataset files 
files = dir('C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\mat_dataset\*.mat');
fullpaths = fullfile({files.folder}, {files.name});                 %concate file folder and file name
aa = struct2cell(files);        % file struct to cell

mat_file_names = string(aa(1,:));           % only file name to file_names

file_names = string(fullpaths);

all_binary_mask = zeros(200,23232);                  

k_meam_group = 6;   % k_mean_group 
th = 4;             % thershold

% reading Mat dataset files 
% start 14 files 1 - 13 
for i =15 : 43                    %length(file_names)
    file_name = load(file_names(i));            %load mat file 
    all_data  = file_name.all_data;             %read mat all_data 
    all_data_size = size(all_data);             %size of all_data
    
    for j = 1 : all_data_size(1)                % loop for one mat file 200 rows  
        
        data1 = all_data(j,:);                  % read j row and all col data
        % function parameters are (Data array and K Mean Number)
        binary_mask = function_cluster_binarymask(data1,k_meam_group,th);   %return cluster and binary mask row only
        all_binary_mask(j,:) = binary_mask;
        reshape_img = reshape(binary_mask,[176,132]);           %reshape binary mask 
        %figure,surf(reshape_img)
        
        %save binary image(clustered) to G6 and thershod 4 folder
        %foldername1 = 'C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\G6\Threshod 4';
        %filename1 = fullfile(foldername1, sprintf('_%s__G%d_%d.png',mat_file_names(i),k_meam_group, j));
        %imwrite(reshape_img, filename1);        %write image


        %save binary image(clustered) to G6 and thershod 4 folder
        foldername1 = 'C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\K Mean\G6\Threshod 4\Crop_all';
        foldername1 = 'C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\K Mean\G6\Threshod 4\Crop_all\remove_noise';
        foldername1 = 'C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\K Mean\G6\Threshod 4\Crop_all\remove_noise\remove_onlyblack';
        
        crop_img  = reshape_img(1:176,14:115);  % crop image 
        crop_img  = im2bw(crop_img);          % convert to 1 and 0 
        crop_img  = bwareaopen(crop_img,800);  % remove small noise 
        stats= regionprops(crop_img); 
        
        if crop_img(:,:) == 0               %imwrite only 1 value image 
            %sprintf('hi')

        else
            if mod(j,2) == 0
                filename1 = fullfile(foldername1, sprintf('_%s__%d.png',mat_file_names(i), (j*2 +1) ));
                imwrite(crop_img, filename1);        %write image
                
            else
                filename1 = fullfile(foldername1, sprintf('_%s__%d.png',mat_file_names(i), ((j*1)+2) ));
                imwrite(crop_img, filename1);        %write image
                
            end
        end
    
    end
    fprintf("%s\n",mat_file_names(i))
    
end

%{

load all_data.mat all_data                      %loading all depth value from all_data.mat
a = size(all_data);
all_binary_mask = zeros(200,23232); 

for i=1 : a(1) 
    data1 = all_data(i,1:23232);                    %read 1 row of depth value
    
    binary_mask = function_cluster_binarymask(data1);   %function cluster and binary mask
    all_binary_mask(i,:) = binary_mask;
    reshape_img = reshape(binary_mask,[176,132]);

    foldername = 'C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\new';
    filename = fullfile(foldername, sprintf('%d.png', i));
    imwrite(reshape_img, filename);

    %{
    if mod(i,2) == 0 
        filename = fullfile(foldername, sprintf('%d.png', i*2 +1));
        imwrite(reshape_img, filename);
    elseif mod(i,2) ~= 0
         filename = fullfile(foldername, sprintf('%d.png', (i*1)+2));
         imwrite(reshape_img, filename);
    end
    %}
end

save all_binary_mask.mat all_binary_mask1
csvwrite('All_Binary_Mask.csv',all_binary_mask)

%}