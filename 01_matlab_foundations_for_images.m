%% 01. MATLAB Foundations -> Scientific Thinking -> Images
% Author: Md. Mobarak Karim, Ph.D.
% Level: Complete beginner
%
% Goal:
% Learn the MATLAB language used throughout this course without needing a
% separate programming tutorial first.
%
% Learning rule:
% Before running each %% section, predict what it should do. Then run it,
% inspect the result, change one value, and explain why the result changed.

%% 1. How MATLAB code works
% MATLAB normally executes a script from top to bottom.
% ;  suppresses Command Window output
% %  starts a comment
% %% starts a runnable section

x = 5;
y = x + 2;
disp(y)

%% 2. Useful learning commands
% clc       clear Command Window text
% clear     remove workspace variables
% close all close figure windows
% whos      inspect variables, sizes, classes, memory
% help NAME short help
% doc NAME  full documentation

whos

%% 3. Variables and scientific naming
% A variable is a name referring to a value.
% Prefer names that explain meaning and units.

pixelSize_um = 0.65;
thresholdValue = 120;
exposure_ms = 25;
sampleName = "mouse_embryo";
isValid = true;

%% 4. Basic data types
% double  default numeric type
% single  lower-precision floating point
% uint8   common 8-bit image type
% uint16  common 16-bit scientific image type
% logical true/false
% string  modern text type
% char    older character-array text type

count = 12;
piApprox = 3.14159;
label = "cell";
flag = true;

class(count)
class(label)
class(flag)

%% 5. Type conversion
textValue = "42";
numberValue = str2double(textValue);
disp(numberValue)

u8 = uint8(200);
d = double(u8);
disp([double(u8), d])

%% 6. Arithmetic operators
% +  -  *  /  ^
%
% IMPORTANT FOR ARRAYS:
% .*  element-wise multiplication
% ./  element-wise division
% .^  element-wise power
%
% Ask: is this matrix algebra or element-by-element arithmetic?

a = 10;
b = 3;
disp(a + b)
disp(a - b)
disp(a * b)
disp(a / b)
disp(a ^ b)

%% 7. Order of operations
result1 = 3 + 4 * 5;
result2 = (3 + 4) * 5;
disp([result1 result2])

%% 8. Formula -> MATLAB checklist
% 1. Write the original equation.
% 2. Identify every symbol.
% 3. State units.
% 4. Identify inputs.
% 5. Identify output.
% 6. Translate operators.
% 7. Decide scalar vs matrix vs element-wise operations.
% 8. Preserve grouping with parentheses.
% 9. Test a known/simple case.
% 10. Check expected physical trend.
% 11. Check output units.

%% 9. Formula example: circle area
% A = pi*r^2
radius_um = 5;
area_um2 = pi * radius_um^2;
fprintf('Area = %.3f um^2\n', area_um2)

% Validation
assert(abs(pi*1^2 - pi) < 1e-12)

%% 10. Formula example: linear equation
% y = m*x + b
slope = 2.5;
xValue = 4;
intercept = 1.2;
yValue = slope * xValue + intercept;
disp(yValue)

%% 11. Formula example: exponential attenuation
% I = I0*exp(-mu*z)
% Checks:
% z=0 -> I=I0
% for mu>0, I decreases with z
% mu*z must be dimensionless

I0 = 1.0;
mu_per_mm = 2.0;
z_mm = [0 0.5 1 2];
I = I0 .* exp(-mu_per_mm .* z_mm);
disp(table(z_mm(:), I(:), 'VariableNames', {'Depth_mm','Intensity'}))

%% 12. Formula example: Euclidean distance
x1 = 2; y1 = 3;
x2 = 8; y2 = 11;
distance = sqrt((x2-x1)^2 + (y2-y1)^2);
disp(distance)

%% 13. Formula example: min-max normalization
values = [10 20 30 40 50];
valuesNorm = (values - min(values)) ./ (max(values) - min(values));
disp(valuesNorm)

%% 14. Formula example: Gaussian
x = -5:0.1:5;
mu = 0;
sigma = 1;
G = exp(-((x-mu).^2) ./ (2*sigma^2));
figure
plot(x,G,'LineWidth',1.5)
grid on
xlabel('x')
ylabel('G(x)')
title('Gaussian function')

%% 15. Think before coding
% Example question:
% Keep an object only if area >= 100 pixels AND mean intensity > 120.

area_px = 250;
meanIntensity = 160;
keepObject = (area_px >= 100) && (meanIntensity > 120);
disp(keepObject)

%% 16. Pseudocode
% Write plain-language logic before exact syntax:
%
% LOAD image
% INSPECT size/class/range
% IF RGB
%     convert to grayscale
% END
% SMOOTH only if needed
% COMPUTE threshold
% CREATE mask
% CLEAN mask
% LABEL objects
% VALIDATE overlay
% MEASURE
% SAVE results

%% 17. Row vectors, column vectors, matrices
rowVector = [10 20 30 40];
columnVector = [10;20;30;40];
M = [1 2 3; 4 5 6; 7 8 9];
disp(M)
size(M)

%% 18. Colon operator
indices = 1:5;
evenValues = 0:2:10;
disp(indices)
disp(evenValues)

%% 19. MATLAB indexing starts at 1
values = [10 20 30 40 50];
firstValue = values(1);
lastValue = values(end);
middleValues = values(2:4);
disp(firstValue)
disp(lastValue)
disp(middleValues)

%% 20. Matrix indexing
M = [10 20 30;40 50 60;70 80 90];
center = M(2,2);
firstTwoRows = M(1:2,:);
lastTwoCols = M(:,2:3);
disp(center)
disp(firstTwoRows)
disp(lastTwoCols)

%% 21. Strings
sample = "zebrafish";
stage = "48 hpf";
message = sample + " at " + stage;
disp(message)

%% 22. Cell arrays
mixed = {"sampleA", 42, true};
disp(mixed{1})
disp(mixed{2})

%% 23. Structures
params.sigma = 1.0;
params.threshold = 120;
params.method = "otsu";
disp(params)

%% 24. Tables
objectID = (1:3)';
area_px = [120;250;175];
meanIntensity = [90;150;130];
T = table(objectID, area_px, meanIntensity);
disp(T)

%% 25. Comparison operators
% == ~= > < >= <=
x = 10;
disp(x == 10)
disp(x ~= 5)
disp(x > 7)

%% 26. Logical operators
% Scalars: && || ~
% Arrays:  &  |  ~
area = 250;
intensity = 160;
keep = (area > 100) && (intensity > 120);
disp(keep)

%% 27. if / elseif / else
meanIntensity = 135;
if meanIntensity > 180
    category = "bright";
elseif meanIntensity > 100
    category = "medium";
else
    category = "dim";
end
disp(category)

%% 28. switch / case
method = "otsu";
switch method
    case "otsu"
        message = "Use global Otsu thresholding.";
    case "adaptive"
        message = "Use adaptive thresholding.";
    otherwise
        message = "Unknown method.";
end
disp(message)

%% 29. for loops
files = ["a.tif","b.tif","c.tif"];
for i = 1:numel(files)
    fprintf('File %d: %s\n', i, files(i))
end

%% 30. Loop over parameter values
thresholds = [80 100 120 140];
for threshold = thresholds
    fprintf('Testing threshold = %d\n', threshold)
end

%% 31. while loops
count = 0;
while count < 3
    disp(count)
    count = count + 1;
end

%% 32. break and continue
values = [5 -2 8 -1 10];
for i = 1:numel(values)
    value = values(i);
    if value < 0
        continue
    end
    disp(value)
    if value == 10
        break
    end
end

%% 33. Calling built-in functions
values = [10 20 30 40];
disp(mean(values))
disp(max(values))
disp(numel(values))

%% 34. Positional and name-value arguments
% Many MATLAB functions use required inputs followed by name-value pairs.
% Example later:
% imgaussfilt(image,1.5,'Padding','replicate')

%% 35. Anonymous functions
squareValue = @(x) x.^2;
disp(squareValue([1 2 3 4]))

%% 36. Scripts vs functions
% Script: convenient for exploration and teaching.
% Function: explicit inputs/outputs, local workspace, reusable logic.
% Good workflow: explore -> understand -> convert stable logic to function.

%% 37. Files and paths
folder = "data";
filename = "image.tif";
imagePath = fullfile(folder, filename);
disp(imagePath)

%% 38. Listing files
files = dir(fullfile("data","*.tif"));
fprintf('Found %d TIFF files\n', numel(files))

%% 39. Common errors
% Undefined variable/function
% Index exceeds array bounds
% Matrix dimensions incompatible
% Wrong use of * instead of .*
% Unexpected image class/range
% Missing toolbox
%
% Debugging habit:
% 1. Read the first useful error.
% 2. Find the exact line.
% 3. Inspect inputs using whos, size, class, min, max.
% 4. Reproduce with a small example.
% 5. Fix one issue at a time.

%% 40. try / catch
try
    testImage = imread('this_file_does_not_exist.tif'); %#ok<NASGU>
catch ME
    fprintf('Caught error: %s\n', ME.message)
end

%% 41. assert
pixelSize_um = 0.5;
assert(pixelSize_um > 0, 'Pixel size must be positive.')

%% 42. Images are matrices
image = imread('cameraman.tif');
fprintf('Class: %s\n', class(image))
fprintf('Size: %d x %d\n', size(image,1), size(image,2))
fprintf('Range: %g to %g\n', double(min(image(:))), double(max(image(:))))

figure
imshow(image)
title('Image as a MATLAB matrix')

%% 43. Pixel indexing and cropping
pixel = image(100,120);
crop = image(80:180,100:220);
fprintf('Selected pixel = %d\n', pixel)
figure
imshow(crop)
title('Cropped region')

%% 44. Logical masks
mask = image > 140;
figure
imshow(mask)
title('Logical mask: image > 140')

%% 45. Vectorized image arithmetic
imageDouble = double(image);
normalized = (imageDouble - min(imageDouble(:))) ./ ...
    (max(imageDouble(:)) - min(imageDouble(:)));
figure
imshow(normalized)
title('Min-max normalized image')

%% 46. Image statistics
fprintf('Mean = %.3f\n', mean(imageDouble(:)))
fprintf('Std  = %.3f\n', std(imageDouble(:)))
fprintf('Median = %.3f\n', median(imageDouble(:)))

%% 47. Pixel area -> physical area
pixelSizeY_um = 0.5;
pixelSizeX_um = 0.5;
area_pixels = 250;
area_um2 = area_pixels * pixelSizeY_um * pixelSizeX_um;
fprintf('Area = %.3f um^2\n', area_um2)

%% 48. Practice
% 1. Create descriptive variables for wavelength, exposure, and pixel size.
% 2. Write an if/elseif/else block that classifies an intensity.
% 3. Use a for loop to test five threshold values.
% 4. Write the equation y = a*x^2 + b*x + c in MATLAB.
% 5. For a vector x, explain why x.^2 is needed.
% 6. Crop a different region from cameraman.tif.
% 7. Create a logical mask using the crop mean as threshold.
% 8. Convert a measured pixel area into um^2.

%% 49. Final takeaway
% The goal is not memorizing syntax. The transferable skill is:
%
% question -> variables/units -> equation/logic -> MATLAB -> test -> validate
%
% The later image-processing lessons repeatedly use these same ideas.
