function preprocess_images(rawFolder)

% Photogrammetry image pre-processing workflow for COLOR Lab

% To run this script, there needs to be a folder called "raw" (lower case) that contains the
% raw images.
% You need to have Adobe DNG converter installed as a stand-alone
% application

% Main operations

% 1) RAW--> DNG --> linear tiff
% 2) linear tiff --> contrast stretched JPG (same size)

% This script prepares a bunch of folders we will populate later
folders = makeLocalFolders_pg(rawFolder);

% Call the DNG converter to make DNG images
raw2dng_pg(folders);

% Now convert the images to linear tiffs -nice to have but too big and dark
dng2tiff_pg(folders)

% Save contrast stretched JPGs - these are our inputs to photogrammetry
contraststretchedjpgs_pg(folders)

% Remove DNG and linear tiff to save space


