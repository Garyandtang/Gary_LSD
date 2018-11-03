% clear;clc;
% img_path = 'undistortedImage/1.png';
% %img_path = 'chairs.pgm';
% a = detect(img_path);% a is the image
% lines_list = flsd(a);
% % lines_list = mergeLine(lines_list);
% img = imread(img_path);
% figure,
% hold on
% imagesc(img);
% colormap bone;
% for i = 1: size(lines_list,1)
%     plot([lines_list(i,2),lines_list(i,4)],[lines_list(i,1),lines_list(i,3)],'red','linewidth',1);
% end
% axis ij
% hold off
lines_list = and;
merge_lines_list = zeros(0, 4);
unsorted_lines_list = lines_list(:, 1:4);
unsorted_lines_list = [unsorted_lines_list, zeros(size(unsorted_lines_list,1),3)];
%computer the k and b for all line segments

k_list = zeros(size(unsorted_lines_list,1), 1);

theta_list = zeros(size(unsorted_lines_list,1), 1);

for i = 1 : size(unsorted_lines_list, 1)
    k_list(i) = (unsorted_lines_list(i,1) - unsorted_lines_list(i,3))/(unsorted_lines_list(i,2) - unsorted_lines_list(i,4));
    theta_list(i) = atan(k_list(i)) * 180 / pi;
    unsorted_lines_list(i,5) =  theta_list(i);
end
b_threshold = 1000; %max(b_list);

%sort lines_list based on the value of theta
[a, index] = sort(unsorted_lines_list(:,5),'descend');
unsorted_lines_list = unsorted_lines_list(index, [1,2,3,4,5,6,7]);
ans_1 = unsorted_lines_list;

%Get the fitline based on theta and b
theta_step = 180 / 1800;
b_step = b_threshold / 20;
theta_threshold = 90;
lines_list_size = size(unsorted_lines_list, 1);

while lines_list_size ~= 0
    theta_threshold = theta_threshold - theta_step;
    theta_lines_list_counter = 0;
    theta_lines_list = zeros(0,7);
    %to find a group of line segments with similar k
    if theta_threshold > -90
        for i = 1: size(unsorted_lines_list, 1)
            if unsorted_lines_list(i,5) >= theta_threshold
                theta_lines_list = [theta_lines_list; unsorted_lines_list(i,:)];
                theta_lines_list_counter = theta_lines_list_counter + 1;
            else
                if theta_lines_list_counter == 0
                     break;
                else
                    unsorted_lines_list(1 : theta_lines_list_counter, :) = [];
                    break;
                end
            end
        end
       
        for i = 1 : size(theta_lines_list, 1)
            merge_line = zeros(0,7);
            for j = i : size(theta_lines_list, 1)
                if theta_lines_list(j, 7) == 0
                    if j == i
                        theta_lines_list(j,6) = theta_lines_list(j, 5);
                    else
                        y_min = min([theta_lines_list(j,1),theta_lines_list(j,3),theta_lines_list(i,1),theta_lines_list(i,3)]);
                        y_max = max([theta_lines_list(j,1),theta_lines_list(j,3),theta_lines_list(i,1),theta_lines_list(i,3)]);
                        x_min = min([theta_lines_list(j,2),theta_lines_list(j,4),theta_lines_list(i,2),theta_lines_list(i,4)]);
                        x_max = max([theta_lines_list(j,2),theta_lines_list(j,4),theta_lines_list(i,2),theta_lines_list(i,4)]);

                        if theta_lines_list(j,5) >= 0
                            theta_lines_list(j,6) = (y_max - y_min) / (x_max -x_min);
                        else
                            theta_lines_list(j,6) = -(y_max - y_min) / (x_max -x_min);
                        end
                    end
                    if theta_lines_list(j,6) > (theta_lines_list(i,6) - 0.0000005) && theta_lines_list(j,6) < (theta_lines_list(i,6) + 0.0000005)
                        theta_lines_list(j,7) = theta_lines_list(j,7) + 1;
                        merge_line = [merge_line; theta_lines_list];
                    end
                end
            end
            y_min_ = min(min(merge_line(:,1)), min(merge_line(:, 3)));
            y_max_ = max(max(merge_line(:,1)), max(merge_line(:, 3)));
            x_min_ = min(min(merge_line(:,2)), min(merge_line(:, 4)));
            x_max_ = max(max(merge_line(:,1)), max(merge_line(:, 3)));
            if size(merge_line, 1) == 0
                continue;
            end
            if merge_line(1,5) >= 0
                merge_lines_list = [merge_lines_list; [y_min, x_min, y_max, x_max]];
            else
                merge_lines_list = [merge_lines_list; [y_min, x_max, y_max, x_min]];
            end
        end

    
    else
         unsorted_lines_list = [];
    end
    lines_list_size = size(unsorted_lines_list, 1);
    
%     % no theta_lines_list
%     if theta_lines_list_counter == 0
%         continue;
%     end
%     

          
            
    
end
img_path = 'undistortedImage/12.png';
%img_path = 'chairs.pgm';
img = imread(img_path);
figure,
hold on
imagesc(img);
colormap bone;
for i = 1: size(merge_lines_list,1)
    plot([merge_lines_list(i,2),merge_lines_list(i,4)],[merge_lines_list(i,1),merge_lines_list(i,3)],'red','linewidth',1);
end
axis ij
hold off