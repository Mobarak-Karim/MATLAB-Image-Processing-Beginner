%% 08. Color and Multichannel Images
% Author: Md. Mobarak Karim, Ph.D.

RGB = imread('peppers.png');

%% 1. RGB is height x width x 3
fprintf('RGB size: %s\n',mat2str(size(RGB)))
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

figure
tiledlayout(2,2)
nexttile; imshow(RGB); title('RGB')
nexttile; imshow(R); title('Red channel')
nexttile; imshow(G); title('Green channel')
nexttile; imshow(B); title('Blue channel')

%% 2. RGB is not the same as scientific multichannel fluorescence
% RGB channels describe a color image. Scientific channels may correspond to
% fluorophores, stains, wavelengths, detectors, or molecular markers.
% Do not convert scientific multichannel data to grayscale automatically.

%% 3. Synthetic two-channel fluorescence example
[x,y] = meshgrid(1:256,1:256);
ch1 = exp(-((x-90).^2 + (y-120).^2)/(2*25^2));
ch1 = ch1 + 0.8*exp(-((x-170).^2 + (y-150).^2)/(2*18^2));
ch2 = exp(-((x-130).^2 + (y-90).^2)/(2*22^2));
ch2 = ch2 + 0.7*exp(-((x-185).^2 + (y-190).^2)/(2*28^2));

figure
tiledlayout(1,2)
nexttile; imagesc(ch1); axis image off; colorbar; title('Synthetic channel 1')
nexttile; imagesc(ch2); axis image off; colorbar; title('Synthetic channel 2')

%% 4. Segment one channel, measure another
BW = ch1 > 0.35;
stats = regionprops('table',BW,ch2,'Area','MeanIntensity');
disp(stats)

%% 5. Key principle
% Segmentation channel and measurement channel can differ. Record exactly
% which channel defines objects and which channel supplies intensity metrics.

%% Practice
% 1. Change the threshold on ch1.
% 2. Segment ch2 instead and compare.
% 3. Explain why channel identity is metadata, not merely a display color.
