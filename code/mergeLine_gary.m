function result = mergeLine(lines_list)
merge_lines_list = zeros(0, 6);
unsorted_lines_list = lines_list(:, 1:4);
unsorted_lines_list = [unsorted_lines_list, zeros(size(unsorted_lines_list,1),2)];
%computer the k and b for all line segments

k_list = zeros(size(unsorted_lines_list,1), 1);
b_list = zeros(size(unsorted_lines_list,1), 1);
theta_list = zeros(size(unsorted_lines_list,1), 1);

for i = 1 : size(unsorted_lines_list, 1)
    k_list(i) = (unsorted_lines_list(i,1) - unsorted_lines_list(i,3))/(unsorted_lines_list(i,2) - unsorted_lines_list(i,4));
    theta_list(i) = atan(k_list(i)) * 180 / pi;
    b_list(i) = unsorted_lines_list(i,1) - k_list(i) * unsorted_lines_list(i,2);
    unsorted_lines_list(i,5) =  theta_list(i);
    unsorted_lines_list(i,6) =  b_list(i);
end
b_threshold = 1000; %max(b_list);

%sort lines_list based on the value of theta
[a, index] = sort(unsorted_lines_list(:,5),'descend');
unsorted_lines_list = unsorted_lines_list(index, [1,2,3,4,5,6]);


%Get the fitline based on theta and b
theta_step = 180 / 18;
b_step = b_threshold / 20;
theta_threshold = 90;
lines_list_size = size(unsorted_lines_list, 1);

while lines_list_size ~= 0
    theta_lines_list = zeros(0,6);
    theta_threshold = theta_threshold - theta_step;
    theta_lines_list_counter = 0;
    
    %to find a group of line segments with similar k
    for i = 1: size(unsorted_lines_list, 1)
        if unsorted_lines_list(i,5) >= theta_threshold
            theta_lines_list = [theta_lines_list; unsorted_lines_list(i,:)];
            theta_lines_list_counter = theta_lines_list_counter + 1;
        else
            if theta_lines_list_counter == 0
                 break;
            else
                unsorted_lines_list(1 : theta_lines_list_counter, :) = [];
                lines_list_size = size(unsorted_lines_list, 1);
                break;
            end
            
        end
    end
    
    % no theta_lines_list
    if theta_lines_list_counter == 0
        continue;
    end
    
    %sort theta_lines_list based on the value of b
    [a, index_] = sort(theta_lines_list(:,6),'descend');
    theta_lines_list = theta_lines_list(index_, [1,2,3,4,5,6]);
    theta_lines_list_size = size(theta_lines_list, 1);
    
    while theta_lines_list_size ~= 0
        b_lines_list = zeros(0, 6);
        b_threshold = b_threshold - b_step;
        b_lines_list_counter = 0;
      
        %to find a group of line segments with similar b
      
        for i =1 : size(b_lines_list, 1)
            if theta_lines_list(i,6) >= b_threshold
                b_lines_list = [b_lines_list; theta_lines_list(i, :)];
                b_lines_list_counter = b_lines_list_counter + 1;
            else
                if b_lines_list_counter == 0
                    break;
                else
                    % if theta >=   0
                    if b_lines_list(b_lines_list_counter, 5) >= 0
                        start_point_y = min(min(b_lines_list(:, 1)), min(b_lines_list(:,3)));
                        start_point_x = min(min(b_lines_list(:, 2)), min(b_lines_list(:,4)));
                        end_point_y = max(max(b_lines_list(:, 1)), max(b_lines_list(:,3)));
                        end_point_x = max(max(b_lines_list(:, 1)), max(b_lines_list(:,3)));
                        merge_line = [start_point_y, start_point_x, end_point_y, end_point_x];
                        merge_lines_list = [merge_lines_list; merge_line];
                        theta_lines_list(1: b_lines_list_counter, :) = [];
                        theta_lines_list_size = size(theta_lines_list, 1);
                    else
                        %if theta < 0 
                        start_point_y = max(max(b_lines_list(:, 1)), max(b_lines_list(:,3)));
                        start_point_x = min(min(b_lines_list(:, 2)), min(b_lines_list(:,4)));
                        end_point_y = min(min(b_lines_list(:, 1)), min(b_lines_list(:,3)));
                        end_point_x = max(max(b_lines_list(:, 1)), max(b_lines_list(:,3)));
                        merge_line = [start_point_y, start_point_x, end_point_y, end_point_x];
                        merge_lines_list = [merge_lines_list; merge_line];
                        theta_lines_list(1: b_lines_list_counter, :) = [];
                        theta_lines_list_size = size(theta_lines_list, 1);
                    end
                end
            end
            b_lines_list_size = size(theta_lines_list, 1);
        end
    end
end
result = merge_lines_list;