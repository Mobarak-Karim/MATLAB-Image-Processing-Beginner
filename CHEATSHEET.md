# MATLAB Beginner Cheat Sheet

**Author: Md. Mobarak Karim, Ph.D.**

Use this for quick recall after you understand the concepts.

## Core syntax

```matlab
x = 5;              % assignment
name = "sample";   % string
flag = true;        % logical
```

## Inspect variables

```matlab
whos
class(x)
size(x)
numel(x)
```

## Vectors and matrices

```matlab
row = [1 2 3];
col = [1;2;3];
M = [1 2;3 4];
```

## Indexing

```matlab
x(1)          % first element
x(end)        % last element
x(2:4)        % slice
M(2,3)        % row 2, column 3
M(:,2)        % all rows, column 2
```

## Element-wise math

```matlab
A .* B
A ./ B
A .^ 2
```

## Conditions

```matlab
if x > 10
    disp("high")
elseif x > 5
    disp("medium")
else
    disp("low")
end
```

## switch/case

```matlab
switch method
    case "otsu"
        disp("global threshold")
    otherwise
        disp("other")
end
```

## for loop

```matlab
for i = 1:5
    disp(i)
end
```

## while loop

```matlab
count = 0;
while count < 3
    count = count + 1;
end
```

## Function pattern

```matlab
function y = squareValue(x)
    y = x.^2;
end
```

## Read/display image

```matlab
I = imread('image.tif');
imshow(I)
```

## Inspect image

```matlab
size(I)
class(I)
min(I(:))
max(I(:))
```

## Convert image

```matlab
Id = im2double(I);
```

## Histogram

```matlab
imhist(I)
```

## Gaussian filter

```matlab
If = imgaussfilt(Id,1.0);
```

## Median filter

```matlab
If = medfilt2(I,[3 3]);
```

## Otsu threshold

```matlab
level = graythresh(I);
BW = imbinarize(I,level);
```

## Adaptive threshold

```matlab
T = adaptthresh(I,0.5);
BW = imbinarize(I,T);
```

## Morphology

```matlab
BW = bwareaopen(BW,50);
BW = imfill(BW,'holes');
se = strel('disk',2);
BW = imopen(BW,se);
```

## Label and measure

```matlab
CC = bwconncomp(BW);
stats = regionprops('table',BW,I,'Area','Centroid','MeanIntensity');
```

## Save table

```matlab
writetable(stats,'outputs/results.csv')
```

## Debugging habit

```matlab
whos
size(variable)
class(variable)
```

Then read the exact error and inspect the inputs to that line.
