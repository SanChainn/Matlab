
% function clustering 4 group 
function binary_mask  = function_cluster_binarymask(depth_img_row, num , th)
    
    data = depth_img_row;                  
    [classLabels, centroids] = kmeans(data', num);                % Find num group cluster
    [sortedCentroid, sortOrder] = sort(centroids, 'ascend');    % Sort the centroids by distance from 0
    newClassLabels = zeros(size(classLabels));  %make zero array
    
    % Now relabel each point with the class label that we WANT it to be.
    for k = 1 : length(classLabels)
	    originalLabel = classLabels(k);
	    newClassLabels(k) = find(sortOrder == originalLabel);
	    %fprintf('For point #%d (= %2d), an original class label of %d will now be %d\n', k, data(k), originalLabel,newClassLabels(k));
    end

    %{
    %------------------------plotting clustering group---------
    figure
    plot(newClassLabels,data,'rx')
    hold on
    plot(sortedCentroid,'kx') 
    title 'Depth Region Grouping';
    ylabel 'Depth value';
    xlabel 'Group Number'; 
    legend('Region 1','Region 2')
    hold off
    %----------------------------------------------------
    %}

    %----------------Binary Masking 0 and 255 if group 3 and more ------------------
    data1 = data;
    for k = 1 : length(classLabels)
        if newClassLabels(k) >= th 
            data1(k) = 0;
        else
            data1(k) = 255;
        end
    end
    %----------------------------------------------------

    binary_mask = data1;        % return binary mask    

    
end





 



