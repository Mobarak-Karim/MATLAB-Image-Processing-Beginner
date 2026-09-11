%% 02. Reading, Displaying, and Understanding Image Types
% Author: Md. Mobarak Karim, Ph.D.

%% 1. Read an image
I = imread('cameraman.tif');

%% 2. Inspect before processing
fprintf('Class: %s\n', class(I))
fprintf('Dimensions: %s\n', mat2str(size(I)))
fprintf('Min: %g, Max: %g\n', double(min(I(:))), double(max(I(:))))

%% 3. Display grayscale correctly
figure
imshow(I)
title('Original grayscale image')

%% 4. Display mapping vs changing data
figure
imagesc(I)
axis image off
colormap gray
colorbar
title('imagesc changes display mapping, not stored pixels')

%% 5. RGB image
RGB = imread('peppers.png');
fprintf('RGB size: %s\n', mat2str(size(RGB)))
figure
imshow(RGB)
title('RGB image')

%% 6. Access channels
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);
figure
tiledlayout(1,3)
nexttile; imshow(R); title('Red')
nexttile; imshow(G); title('Green')
nexttile; imshow(B); title('Blue')

%% 7. Convert RGB to grayscale
Gray = rgb2gray(RGB);
figure
imshow(Gray)
title('RGB converted to grayscale')

%% 8. Understand class and range
% uint8 usually uses 0..255.
% uint16 usually uses 0..65535.
% double/single images often use 0..1 for image-processing functions, but
% scientific arrays can use other numeric ranges.

%% 9. Convert for quantitative arithmetic
Id = im2double(I);
fprintf('Converted class: %s, range: %.3f to %.3f\n', ...
    class(Id), min(Id(:)), max(Id(:)))

%% 10. im2double vs double
% double(uint8Image) gives numeric values like 0..255.
% im2double(uint8Image) rescales to 0..1.
rawDouble = double(I);
scaledDouble = im2double(I);
fprintf('double range: %.1f..%.1f\n', min(rawDouble(:)), max(rawDouble(:)))
fprintf('im2double range: %.3f..%.3f\n', min(scaledDouble(:)), max(scaledDouble(:)))

%% 11. Save without overwriting the original
crop = I(50:150,70:170);
imwrite(crop,'example_crop.png')

%% 12. Metadata caution
% Standard PNG/JPEG/TIFF reading is enough for these lessons. Real microscopy
% data may carry pixel size, z-spacing, time, channel, and detector metadata.
% Preserve metadata when it matters to quantitative interpretation.

%% Practice
% 1. Load peppers.png and report class, shape, and range.
% 2. Compare double() and im2double().
% 3. Crop and save a copy under a new filename.
