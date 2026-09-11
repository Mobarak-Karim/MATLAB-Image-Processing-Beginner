%% 10. Final Project: End-to-End Quantitative Image Analysis
% Author: Md. Mobarak Karim, Ph.D.
%
% Question:
% Segment coin-like objects, validate the mask, quantify them, test parameter
% sensitivity, and save results with parameters.

clc
clear
close all

%% 1. Define parameters before analysis
params.gaussianSigma = 1.0;
params.minArea_px = 50;
params.pixelSize_um = 1.0; % replace with real calibration for real data

%% 2. Load and inspect
I = imread('coins.png');
fprintf('Class: %s\n',class(I))
fprintf('Size: %s\n',mat2str(size(I)))
fprintf('Range: %g to %g\n',double(min(I(:))),double(max(I(:))))

figure
imshow(I)
title('Raw image')

%% 3. Inspect histogram
figure
imhist(I)
title('Intensity histogram')

%% 4. Preprocess for a defined reason
% Here mild Gaussian smoothing reduces fine-scale variation before thresholding.
Id = im2double(I);
If = imgaussfilt(Id,params.gaussianSigma);

figure
tiledlayout(1,2)
nexttile; imshow(Id); title('Original double')
nexttile; imshow(If); title('Gaussian filtered')

%% 5. Segment
level = graythresh(If);
BW = imbinarize(If,level);
BW = bwareaopen(BW,params.minArea_px);
BW = imfill(BW,'holes');

%% 6. Validate against the raw image
figure
imshow(I)
hold on
B = bwboundaries(BW);
for k = 1:numel(B)
    b = B{k};
    plot(b(:,2),b(:,1),'LineWidth',1)
end
hold off
title('Validation: segmentation boundaries on raw image')

%% 7. Label and count
CC = bwconncomp(BW);
fprintf('Object count: %d\n',CC.NumObjects)
L = labelmatrix(CC);
figure
imshow(label2rgb(L,'jet','k','shuffle'))
title('Labeled objects')

%% 8. Measure
stats = regionprops('table',BW,I,'Area','Centroid','Perimeter','MeanIntensity');
stats.Area_um2 = stats.Area * params.pixelSize_um^2;
disp(stats(1:min(10,height(stats)),:))

%% 9. Examine distributions
figure
histogram(stats.Area_um2)
xlabel('Area (um^2)')
ylabel('Count')
title('Object-area distribution')

%% 10. Parameter sensitivity
sigmas = [0.5 1 2 3];
counts = zeros(size(sigmas));
for i = 1:numel(sigmas)
    Itest = imgaussfilt(Id,sigmas(i));
    BWtest = imbinarize(Itest,graythresh(Itest));
    BWtest = bwareaopen(BWtest,params.minArea_px);
    BWtest = imfill(BWtest,'holes');
    counts(i) = bwconncomp(BWtest).NumObjects;
end

disp(table(sigmas(:),counts(:),'VariableNames',{'Sigma','ObjectCount'}))

%% 11. Save results and parameters
if ~exist('outputs','dir')
    mkdir('outputs')
end
writetable(stats,'outputs/final_project_measurements.csv')
save('outputs/final_project_parameters.mat','params','level')

%% 12. Final checklist
% Before accepting a quantitative result, ask:
% - Did I define the biological/analytical question?
% - Did I inspect class, range, and channels?
% - Was preprocessing justified?
% - Did I validate the mask on raw data?
% - Are units/calibration correct?
% - Are conclusions stable to reasonable parameter changes?
% - Did I save parameters and outputs reproducibly?
