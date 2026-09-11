%% 06. Segmentation and Labels
% Author: Md. Mobarak Karim, Ph.D.

I = imread('coins.png');
BW = imbinarize(I,graythresh(I));
BW = bwareaopen(BW,50);
BW = imfill(BW,'holes');

%% 1. Connected components
CC = bwconncomp(BW);
fprintf('Connected objects: %d\n',CC.NumObjects)

%% 2. Label matrix
L = labelmatrix(CC);
figure
imshow(label2rgb(L,'jet','k','shuffle'))
title('Labeled connected components')

%% 3. Validate with boundaries
figure
imshow(I)
hold on
boundaries = bwboundaries(BW);
for k = 1:numel(boundaries)
    b = boundaries{k};
    plot(b(:,2),b(:,1),'LineWidth',1)
end
hold off
title('Segmentation boundaries on original image')

%% 4. Touching objects and watershed
% Connected-component labeling cannot separate objects that share foreground
% pixels. Watershed can help when touching objects form a merged mask.
D = -bwdist(~BW);
D(~BW) = -Inf;
Lw = watershed(D);
BWseparated = BW;
BWseparated(Lw == 0) = 0;
figure
tiledlayout(1,2)
nexttile; imshow(BW); title('Before watershed')
nexttile; imshow(BWseparated); title('Basic watershed separation')

%% 5. Watershed caution
% Naive watershed can over-segment. Use it only when touching objects are a
% real problem, then validate boundaries against the raw image.

%% Practice
% 1. Compare object count before and after watershed.
% 2. Inspect several boundaries manually.
% 3. Explain why a visually neat label image is not enough evidence of correctness.
