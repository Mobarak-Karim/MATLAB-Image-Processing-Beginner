%% 05. Thresholding and Morphology
% Author: Md. Mobarak Karim, Ph.D.

I = imread('coins.png');

%% 1. Global Otsu threshold
level = graythresh(I);
BW = imbinarize(I,level);
figure
tiledlayout(1,2)
nexttile; imshow(I); title('Original')
nexttile; imshow(BW); title(sprintf('Otsu mask, level=%.3f',level))

%% 2. Foreground polarity
% A mask is a logical decision about foreground. If objects are darker than
% background, you may need to invert the comparison/mask.

%% 3. Adaptive thresholding
Tlocal = adaptthresh(I,0.5);
BWlocal = imbinarize(I,Tlocal);
figure
imshow(BWlocal)
title('Adaptive threshold')

%% 4. Remove small components
minArea_px = 50;
BWclean = bwareaopen(BW,minArea_px);

%% 5. Fill holes
BWfilled = imfill(BWclean,'holes');

%% 6. Opening and closing
se = strel('disk',2);
BWopen = imopen(BWfilled,se);
BWclose = imclose(BWopen,se);
figure
tiledlayout(1,3)
nexttile; imshow(BW); title('Initial mask')
nexttile; imshow(BWfilled); title('After cleanup/fill')
nexttile; imshow(BWclose); title('After opening/closing')

%% 7. Why morphology can be dangerous
% Morphology changes shape. A large structuring element can erase real small
% features, merge nearby objects, or alter measured boundaries. Validate every
% cleanup step against the raw image.

%% 8. Global vs adaptive threshold
% Global: one threshold for the whole image; good when foreground/background
% intensity separation is reasonably consistent.
% Adaptive: spatially varying threshold; useful with uneven illumination but
% has more parameters and can amplify local artifacts.

%% Practice
% 1. Compare Otsu and adaptive masks.
% 2. Change minArea_px.
% 3. Change the structuring-element radius.
% 4. Overlay masks on the original before deciding which is best.
