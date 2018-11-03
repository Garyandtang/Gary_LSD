function [lines, w, prec, nfa] = detect(img_path)

img_file_format = strcat(img_path);
img = imread(img_file_format);

%Convert image to double grayscale
if size(img,3) == 3
  img = rgb2gray(img);
end
img_64 = 255 .* im2double(img);
% img_64 = img;
%storeDATA();

imshow(img_64);
lines = img_64;
w = 1;
prec = 1;
nfa = 1;

