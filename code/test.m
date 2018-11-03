% lsd store and draw
img_path = './undistortedImage/1.png';



a = detect(img_path);
lines_list = flsd(a);
lines_list = lines_list(:,1:4);
swap = lines_list(:,1);
lines_list(:,1) = lines_list(:,2);
lines_list(:,2) = swap;
swap = lines_list(:,3);
lines_list(:,3) = lines_list(:,4);
lines_list(:,4) = swap;
% lines_list = and;
fusion_lines = mergeLine(lines_list,5,5,10,180);
% minAngleDis = 5; minDis = 5; minLen = 20; minGap = 180;


img = imread(img_path);
line = fusion_lines;
figure,
hold on
imagesc(img);
colormap bone;
for i = 1: size(line,1)
     plot([line(i,1),line(i,3)],[line(i,2),line(i,4)],'red');
end
axis ij
hold off

img = imread(img_path);
line = lines_list;
figure,
hold on
imagesc(img);
colormap bone;
for i = 1: size(line,1)
     plot([line(i,1),line(i,3)],[line(i,2),line(i,4)],'red');
end
axis ij
hold off