% dng2tiff reads dng file into matlab as linear RGB.

% Status = raw2dng(rawPath) takes as input a dng image, performs steps 1-4
% of the pipeline from Karaimer & Brown code, and saves a tiff image.
%
% Modified from the toolbox released by Karaimer & Brown:
%
% Karaimer, Hakki Can, and Michael S. Brown. ECCV 2016
% "A software platform for manipulating the camera imaging pipeline."
%
% The mac version of dng_validate was written by Ben Singer from Princeton.
%
% Derya Akkaynak 2019 | deryaa@alum.mit.edu


function dng2tiff_pg(folders)

dngfolder = folders.dngFolder;
tifffolder = folders.uncorrectedTiffFolder;

files = dir(fullfile(dngfolder));
files = remove_non_files(files);

for i = 1:numel(files)
    fileName = files(i).name;
    fileExt = fileName(regexp(fileName,'(?:\.)'):end);

    % Carry out first 5 steps of Karaimer & Brown pipeline and read/save tiff
    dngImagePath = fullfile(dngfolder,[fileName(1:end-numel(fileExt)),'.dng']);
    dng2tiff_oneimg(dngImagePath, tifffolder);

end
end

function [I,shortName,outputFilePath] = dng2tiff_oneimg(dngPath, tiffSavePath,stage)
if nargin < 3
    stage = 4;
end
saveFolder = fullfile('.','camera-pipeline-nonUI-master','dngOneExeSDK');
writeTextFile(saveFolder,'wbAndGainSettings',[1 0 0 0]);%[1 0 0 0]
writeTextFile(saveFolder,'rwSettings',0);
writeTextFile(saveFolder,'stageSettings',stage);
writeTextFile(saveFolder,'cam_settings',0);
writeTextFile(saveFolder,'lastStage',stage);


pathParts = strsplit(dngPath,filesep);
fileName = pathParts{end};
shortName = fileName(1:end-4);
outputFilePath = fullfile(tiffSavePath,[shortName,'.tif']);
%
%status = system([fullfile('.','dngOneExeSDK','dng_validate.exe -16 -cs1 -tif ') ,  outputFilePath ' ' dngPath]);

%status = system([fullfile('.','dngOneExeSDK','dng_validate.exe' -16 -3   outputFilePath ' ' dngPath]);
status = system([fullfile('.','camera-pipeline-nonUI-master','dngOneExeSDK','dng_validate.exe -16 -3 ') ,  outputFilePath ' ' dngPath]);


if status~=0
    fprintf(2,['dng2tiff: There was a problem processing the DNG image ',dngPath,'\n']);
    I = [];
else
    % outputs from the Karaimer & Brown code are uint16. Scale to be in
    % [0,1];
    I = double(imread(outputFilePath))./2^16;

end
end

