%% 09. Batch Processing and Reusable Pipelines
% Author: Md. Mobarak Karim, Ph.D.
%
% Goal: turn exploratory steps into a reusable function and process many files.

%% 1. Explicit parameters
params.sigma = 1.0;
params.minArea_px = 50;
params.fillHoles = true;

%% 2. Single-image test
I = imread('coins.png');
[resultTable, BW] = analyzeImage(I,params);
disp(resultTable(1:min(5,height(resultTable)),:))
figure; imshow(BW); title('Pipeline mask')

%% 3. Batch-file pattern
inputFolder = 'data';
outputFolder = 'outputs';
if ~exist(outputFolder,'dir')
    mkdir(outputFolder)
end

files = dir(fullfile(inputFolder,'*.tif'));
allResults = table();

for k = 1:numel(files)
    inputPath = fullfile(files(k).folder,files(k).name);
    I = imread(inputPath);
    [T,~] = analyzeImage(I,params);

    % Record source filename for every object row.
    T.SourceFile = repmat(string(files(k).name),height(T),1);
    allResults = [allResults; T]; %#ok<AGROW>
end

if ~isempty(allResults)
    writetable(allResults,fullfile(outputFolder,'batch_results.csv'))
end

%% 4. Why test one image first?
% Batch processing can repeat a mistake perfectly across hundreds of files.
% Validate the pipeline on representative images before scaling up.

%% 5. Save parameters
save(fullfile(outputFolder,'analysis_parameters.mat'),'params')

%% 6. Reusable local function
function [stats,BW] = analyzeImage(I,params)
    if ndims(I) == 3
        I = rgb2gray(I);
    end

    Id = im2double(I);
    If = imgaussfilt(Id,params.sigma);
    BW = imbinarize(If,graythresh(If));
    BW = bwareaopen(BW,params.minArea_px);

    if params.fillHoles
        BW = imfill(BW,'holes');
    end

    stats = regionprops('table',BW,Id,'Area','MeanIntensity','Centroid');
end
