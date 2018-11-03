clear;
img_path = 'undistortedImage/1.png';
[a, b, c, d] = detect(img_path);% a is the image
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
[xxx,yyy] = flsd(a);
img = imread(img_path);
figure,
hold on
imagesc(img);
colormap bone;
for i = 1:size(xxx,1)
    plot([xxx(1,2),xxx(1,4)],[xxx(1,1),xxx(1,3)],'red');
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