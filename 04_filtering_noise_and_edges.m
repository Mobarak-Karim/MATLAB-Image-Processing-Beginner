%% 04. Filtering, Noise, and Edges
% Author: Md. Mobarak Karim, Ph.D.

I = im2double(imread('cameraman.tif'));

%% 1. Gaussian filtering
% Use Gaussian smoothing for fine-scale approximately Gaussian noise or when
% gentle smoothing is needed before a later step. sigma controls smoothing.
G1 = imgaussfilt(I,1);
G3 = imgaussfilt(I,3);
figure
tiledlayout(1,3)
nexttile; imshow(I); title('Original')
nexttile; imshow(G1); title('Gaussian sigma=1')
nexttile; imshow(G3); title('Gaussian sigma=3')

%% 2. Trade-off
% Increasing sigma suppresses more small-scale variation but also blurs small
% structures and edges. Choose it relative to the feature scale you care about.

%% 3. Median filtering
% Median filtering is useful for impulse/salt-and-pepper noise.
Inoise = imnoise(I,'salt & pepper',0.03);
Imedian = medfilt2(Inoise,[3 3]);
figure
tiledlayout(1,2)
nexttile; imshow(Inoise); title('Salt-and-pepper noise')
nexttile; imshow(Imedian); title('3x3 median filter')

%% 4. Edge detection
edges = edge(I,'sobel');
figure
imshow(edges)
title('Sobel edges')

%% 5. Gaussian vs median
% Gaussian: smooth distributed high-frequency noise; blurs edges gradually.
% Median: robust to isolated extreme pixels; preserves edges better in many
% impulse-noise cases.

%% 6. Validate filtering
% Compare filtered and raw images at the same scale. Do not judge filtering
% only by whether the image looks smoother.

%% Practice
% 1. Compare sigma 0.5, 1, 2, and 4.
% 2. Change median neighborhood size.
% 3. Explain when smoothing could harm segmentation.
