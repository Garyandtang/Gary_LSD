function double_gray_img= detect(img_path)

img_file_format = strcat(img_path);
img = imread(img_file_format);

%Convert image to double grayscale
if size(img,3) == 3
  img = rgb2gray(img);
end
img_64 = 255 .* im2double(img);
double_gray_img = img_64;
