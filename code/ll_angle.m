%{
Finds the angles and the gradients of the image. Generates a list of pseudo ordered points. 
     * 
     * @param scaled_image the image after guassian blur and resize
     * @param threshold    The minimum value of the angle that is considered defined, otherwise NOTDEF 
     * @param n_bins       The number of bins with which gradients are ordered by, using bucket sort. 
     * @param list         Return: Vector of coordinate points that are pseudo ordered by magnitude. 
     *                     Pixels would be ordered by norm value, up to a precision given by max_grad/n_bins. 
%}
%list = [y, x, gradient] ordered by gradient
%angles & modgrad: img_height * img_width matrix 
function [angles, modgrad, list] = ll_angle(scaled_image, threshold, n_bins)
[height, width, dim] = size(scaled_image);

% [modgrad,angles] = imgradient(scaled_image);
% max_grad = max(max(modgrad));

% define arrays for store angles and gradient
angles = zeros(height, width);
modgrad = zeros(height, width);

%Undefined the down and right boundaries
angles(height, :) = -1024.0;
angles(:, width) = -1024.0;
max_grad = -1;

%Computing gradient for remaining piexls
for y = 1 : height-1
    for addr = 1 : width-1
%         DA = (scaled_image(y+1, addr+1) - scaled_image(y, addr));
%         BC = (scaled_image(y+1, addr) - scaled_image(y, addr+1));
        DA = (scaled_image(y+1, addr+1) - scaled_image(y, addr));
        BC = (scaled_image(y+1, addr) - scaled_image(y, addr+1));
        gx = DA + BC;
%         gx = double(gx);
        gy = DA - BC;
%         gy = double(gy);
        norm = sqrt((gx^2 + gy^2)/4);
        modgrad(y, addr) = norm;
        %set angles to nodefine for small gradient
        if norm <= threshold
            angles(y, addr) = -1024.0;
        else
            angles(y, addr) = atan2(gx,-gy);
            if norm > max_grad
                max_grad = norm;
            end
        end
    end
end

%computing histogram of gradient values
count = 1;
if max_grad > 0
    bin_coef = (n_bins - 1) / max_grad;
else
    bin_coef = 0;
end
unsorted_list = zeros(height*width,3);
for y = 1 : height 
    for x = 1 : width 
        if x < width && y < height
            i = modgrad(y, x) * bin_coef;
        else
            i = -1024;
        end
        unsorted_list(count, 1) = y;
        unsorted_list(count, 2) = x;
        unsorted_list(count, 3) = i;
        count= count+1;
    end
end
% list = unsorted_list;
% sort
[a, index] = sort(unsorted_list(:,3),'descend');
list = unsorted_list(index, [1,2 ,3]);
% 
% figure, imshow(angles);
% figure, imshow(modgrad);
% 









