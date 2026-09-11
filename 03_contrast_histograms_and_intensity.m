%% 03. Histograms, Intensity, and Contrast
% Author: Md. Mobarak Karim, Ph.D.

I = imread('pout.tif');

%% 1. Inspect image and histogram
figure
tiledlayout(1,2)
nexttile; imshow(I); title('Original')
nexttile; imhist(I); title('Histogram')

%% 2. Why histograms matter
% A histogram shows how frequently intensity values occur. It can reveal:
% narrow dynamic range, saturation, background peaks, or broad overlap.

%% 3. Global contrast stretching
limits = stretchlim(I,[0.01 0.99]);
Istretch = imadjust(I,limits,[]);
figure
tiledlayout(1,2)
nexttile; imshow(I); title('Original')
nexttile; imshow(Istretch); title('1-99% contrast stretch')

%% 4. Compare histograms
figure
tiledlayout(1,2)
nexttile; imhist(I); title('Original histogram')
nexttile; imhist(Istretch); title('Stretched histogram')

%% 5. Local contrast enhancement
% adapthisteq can help when contrast varies spatially. Use cautiously for
% quantitative analysis because it changes intensity relationships.
Ilocal = adapthisteq(I);
figure
imshow(Ilocal)
title('Adaptive histogram equalization')

%% 6. Display-only contrast
% imshow(I,[low high]) changes display mapping without changing I.
figure
imshow(I,[60 180])
title('Display-only window: 60..180')

%% 7. Quantitative caution
% Before modifying contrast ask: is this only for visualization, or will the
% modified image feed segmentation/measurement? Record transformations that
% change pixel values.

%% Practice
% 1. Try different stretchlim percentiles.
% 2. Compare imadjust with adapthisteq.
% 3. Explain which operations change data and which only change display.
