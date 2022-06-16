
% read all csv file and save all_data.mat 
files = dir('C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\*.csv');
fullpaths = fullfile({files.folder}, {files.name});
aa = struct2cell(files);        % file struct to cell
file_names = aa(1,:);           % only file name to file_names



for k = 1: length(file_names) 
    
    file_ = string(file_names(k));              %convert cell to string
    [filepath,name,ext] = fileparts(file_);     %split file name 

    m = readtable(string(fullpaths(k)));        %read csv file to table
    m1 = table2cell(m);                         %convert table to cell
    all_data = zeros(200,23232);                %make zero array
    for i=1:size(m1,1)
        data1= cell2mat(m1(i,1:23232));
        all_data(i,:) = data1;
    end
    filename = sprintf('%s.mat',name);
    save(filename,'all_data')  
    fprintf('%s.mat\n',name);
end




%this is test
