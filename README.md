# Gary_LSD
The Matlab implementation of Line Segment Detector. Most implementations are based on the standard LSD function in Opencv. For the special need, we merge the short line segments to long line segments.

* [Line Segment Detector](http://www.ipol.im/pub/art/2012/gjmr-lsd/) is a fast and robust algorithm to extract lines segments in images. The details of LSD is shown in this [paper](http://www.ipol.im/pub/art/2012/gjmr-lsd/article.pdf)

## Some Descriptions
* Matlab version: Matlab R2017b or above.

## Usage
Just download the whole repo and run:
```
>> test_all_image
```
The images with merged line segments will shown to you, if you want to get the results with unmerged line segments, just replace code in line 51
```
 line = fusion_lines; 
```
to 
```
line = lines_list;
```
Most parameters on LSD are in flsd.m, and most parameters on line merging are in mergeLine.m. I did not find a good way to orginize the code of this project, if you find any bug, error, strange result, or you have a good way to improve the organization of the code, please don't hesitate to let me know. Let us contribute this project together.
## Visual Result
The upper one is the image with merged line segements and the below one is the image with unmerged line segements.
<p align="center">
  <img src="https://github.com/Garyandtang/Gary_LSD/blob/master/code/merged_result.png" height="500">
  <img src="https://github.com/Garyandtang/Gary_LSD/blob/master/code/lsd_result.png" height="500">
</p>

## Reference
Special thanks to:
* theWorldCreator: https://github.com/theWorldCreator/LSD for the c implementation of the Line Segment Detector.
