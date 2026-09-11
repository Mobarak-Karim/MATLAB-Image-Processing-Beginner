# Which MATLAB Function Should I Use?

**Author: Md. Mobarak Karim, Ph.D.**

This guide is organized by the problem you are trying to solve.

| Problem | Function | Use when | Important control / caution |
|---|---|---|---|
| Read standard image | `imread` | PNG/TIFF/JPEG examples | Metadata-rich microscopy may need a specialized workflow |
| Display image | `imshow` | Correct image-style display | Display does not automatically change stored pixels |
| Inspect histogram | `imhist` | Understand intensity distribution | Histogram alone does not prove object/background separability |
| Convert to normalized floating point | `im2double` | Filtering/arithmetic requiring floating point | Different from `double(I)` for integer images |
| Global contrast stretch | `imadjust` | One global mapping is reasonable | Changes intensities if assigned to a new image |
| Local contrast enhancement | `adapthisteq` | Contrast varies spatially | Can strongly alter quantitative intensity relationships |
| Gaussian smoothing | `imgaussfilt` | Gentle smoothing / Gaussian-like noise | `sigma`; larger values blur smaller features |
| Median filtering | `medfilt2` | Salt-and-pepper/impulse noise | Neighborhood size; large windows remove small detail |
| Edge detection | `edge` | Need gradient/edge map | Edge maps are not automatically object masks |
| Global Otsu threshold | `graythresh` + `imbinarize` | One foreground/background threshold is plausible | Validate polarity and mask visually |
| Adaptive threshold | `adaptthresh` + `imbinarize` | Uneven illumination/background | More parameters; can follow artifacts |
| Remove tiny components | `bwareaopen` | Small disconnected specks are unwanted | Minimum area must have scientific justification |
| Fill enclosed holes | `imfill(BW,'holes')` | Foreground objects should be solid | Can hide real internal structures |
| Morphological opening | `imopen` | Remove small protrusions / objects | Structuring element changes shape |
| Morphological closing | `imclose` | Close narrow gaps | Can connect nearby real objects |
| Connected components | `bwconncomp` | Count/identify disconnected foreground regions | Touching objects remain one component |
| Label matrix | `labelmatrix` | Need integer labels | Use after connected-component analysis |
| Region measurements | `regionprops` | Area, centroid, shape, intensity | Measurements inherit segmentation errors |
| Object boundaries | `bwboundaries` | Visual validation overlays | Use with raw image, not alone |
| Distance transform | `bwdist` | Watershed or distance-based analysis | Interpretation depends on foreground/background convention |
| Watershed | `watershed` | Touching objects need separation | Easy to over-segment; validate carefully |
| List files | `dir` | Batch processing | Use `fullfile` for paths |
| Build paths | `fullfile` | Cross-platform path construction | Prefer over manually typed separators |
| Save table | `writetable` | CSV/tabular results | Include source file and units |

## Decision pattern

Before choosing a function, ask:

1. What exact problem am I fixing?
2. Is the problem global or local?
3. What feature size matters?
4. Which parameter corresponds to that scale?
5. How will I compare the result against the raw image?
6. Will this step change quantitative pixel values or object boundaries?

## Examples

### Salt-and-pepper noise
Try `medfilt2` before Gaussian smoothing because the median is robust to isolated extreme pixels.

### Uneven background
Consider `adaptthresh`, but first confirm that illumination truly varies spatially. A global threshold is simpler and easier to reproduce when it works.

### Touching objects
First verify that objects are genuinely merged in the binary mask. If so, watershed may help; do not use it automatically on every dataset.

### Measurement
Do not begin with `regionprops`. First validate the segmentation mask. Quantitative measurements cannot repair an incorrect mask.
