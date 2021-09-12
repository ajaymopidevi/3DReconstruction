clear all ;
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
#load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');
load('../data/extrinsics.mat','R1', 'R2', 't1', 't2');
load('../data/intrinsics.mat');

%dispM=get_disparity(im1, im2);
dispM = get_disparity_DP(im1, im2);
imwrite(dispM, '../output/disparity_DP.png');

% --------------------  get depth map

depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2);
imwrite(depthM, '../output/depth_DP.png');


% --------------------  Display

figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;
