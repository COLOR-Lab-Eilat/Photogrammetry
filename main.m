% The main script to run the photogrammetry image pre-processing workflow
% Custom made for Neta!
% DA Feb 26, 2024


clear;close;clc

% This is the path of the folder with raw images we want to process.
% Nothing else needs to be changed in this script - just make sure this
% points to the right folder!
rawpath = fullfile('/Users/dakkaynak/Desktop/test/raw');

% This is where the code is
workingdir = '/Users/dakkaynak/Documents/Github/Photogrammetry';

% Add all subfolders to the path
addpath(genpath('.'))

% Create the preprocessed images (in JPG). These are the inputs to Agisoft.
preprocess_images(rawpath);


