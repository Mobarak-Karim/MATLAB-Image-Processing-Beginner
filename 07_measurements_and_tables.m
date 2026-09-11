%% 07. Object Measurements and Tables
% Author: Md. Mobarak Karim, Ph.D.

I = imread('coins.png');
BW = imbinarize(I,graythresh(I));
BW = bwareaopen(BW,50);
BW = imfill(BW,'holes');

%% 1. Measure labeled regions
stats = regionprops('table',BW,I, ...
    'Area','Centroid','Perimeter','Eccentricity','MeanIntensity');
disp(stats(1:min(5,height(stats)),:))

%% 2. Understand columns
% Area is in pixels unless you convert using calibration.
% Centroid is [x y].
% Perimeter and Eccentricity describe shape.
% MeanIntensity uses the supplied intensity image.

%% 3. Physical area
pixelSizeY_um = 0.5;
pixelSizeX_um = 0.5;
stats.Area_um2 = stats.Area * pixelSizeY_um * pixelSizeX_um;

%% 4. Basic quality control
figure
histogram(stats.Area_um2)
xlabel('Area (um^2)')
ylabel('Object count')
title('Area distribution')

%% 5. Filter measurements carefully
% Filtering rows after segmentation is different from changing segmentation.
% Keep criteria explicit and scientifically justified.
keep = stats.Area_um2 >= 20;
statsFiltered = stats(keep,:);
fprintf('Kept %d of %d objects\n',height(statsFiltered),height(stats))

%% 6. Save results
if ~exist('outputs','dir')
    mkdir('outputs')
end
writetable(stats,'outputs/region_measurements.csv')

%% Practice
% 1. Add BoundingBox or EquivDiameter.
% 2. Convert perimeter to physical units if pixels are square.
% 3. Plot MeanIntensity versus Area.
% 4. Explain why measurements are only as trustworthy as segmentation.
