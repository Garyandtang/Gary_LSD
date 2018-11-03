clear;clc;
img_path = 'undistortedImage/26.png';
% img_path = 'test_LSD_data/image_raw_screenshot_16.07.2018_1.png';
%img_path = 'chairs.pgm';
a = detect(img_path);% a is the image
[lines_list, used] = flsd(a);
img = imread(img_path);


%[e, f] = flsd(a);
% x = ll_angle(a, 0,1);
% G = fspecial('gaussian', [3 3], 0.75);
% a = imfilter(a,G,'same');
% [x, y] = imgradient(a,'prewitt');
% figure, imshow(x);
% figure, imshow(y);
% [angles, modgrad, list] = ll_angle(a, 5.2, 1024);
% figure, imshow(modgrad);
% figure, imshow(angles);

%store
% xxx = lines_list;
% lines_list = lines_list(:,1:4);
% swap = lines_list(:,1);
% lines_list(:,1) = lines_list(:,2);
% lines_list(:,2) = swap;
% swap = lines_list(:,3);
% lines_list(:,3) = lines_list(:,4);
% lines_list(:,4) = swap;
% lines_list = lines_list';
% lines_list = lines_list -1;
% fileID = fopen('exptable%d.txt','w');
% fprintf(fileID,'%d %d %d %d\n',lines_list);
% fclose(fileID);
% lines_list = dlmread('exptable%d.txt');
%draw
figure,
hold on
imagesc(img);
colormap bone;
for i = 1: size(lines_list,1)
%     plot([lines_list(i,1)+1,lines_list(i,3)],[lines_list(i,2),lines_list(i,4)],'red');
    plot([lines_list(i,2),lines_list(i,4)],[lines_list(i,1),lines_list(i,3)],'red','linewidth',1);
end
axis ij
hold off


% path = '/home/rpl/Downloads/jiaweit/ipol-matlab/lsd_1.6/Matlab/undistorted/';
% path1 = strcat(path, '29.png');
% path2 = strcat(path, 'line_29.txt');
% img = imread(path1);
% line = dlmread(path2);
% figure,
% hold on
% imagesc(img);
% colormap bone;
% for i=1:size(line,1)
%     plot([line(i,1),line(i,3)],[line(i,2),line(i,4)],'red');
% end
% axis ij
% hold off

% %default parameter
% ANG_TH = 22.5;  
% QUANT = 2.0;                %Bound to the quantization error on the gradient norm;
% SCALE = 0.8;
% SIGMA_SCALE = 0.6;
% 
% %Angle tolerance
% prec = degtorad(ANG_TH);
% p = ANG_TH / 180;
% rho = QUANT / sin(prec);  % Gradient magnitude threshold
% 
% %Gaussian smoothing and resize
% if SCALE ~= 1
%     %Gaussian blur 
%     if SCALE < 1
%         sigma = SIGMA_SCALE / SCALE;
%     else
%         sigma = SCALE;
%     end
%     sprec = 3;
%     h = (ceil(sigma * sqrt(2 * sprec * log(10.0))));
%     n = 1 + 2 * h;
%     G = fspecial('gaussian', [n n], sigma);
%     gaussian_img = imfilter(a,G,'same');
% %     a = gaussian_img;
% %     figure, imshow(gaussian_img);
%       scaled_image = imresize(gaussian_img, SCALE, 'bilinear', 'AntiAliasing', false);
% %     b = scaled_image;
% %     figure, imshow(scaled_image);
% %     
% end
% 
% [angles, modgrad, list] = ll_angle(scaled_image, 5.2, 1024);