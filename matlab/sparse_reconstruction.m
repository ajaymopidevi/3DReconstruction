addpath('../data');
load('../data/someCorresp.mat');
pkg load image
pkg load statistics
load('../data/intrinsics.mat');
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
M = max(size(im1,1), size(im1,2));

F = eightpoint(pts1, pts2,M);
%Epipolar correspondence
load('../data/templeCoords.mat');
pts2 = epipolarCorrespondence(im1, im2, F, pts1);

E = essentialMatrix(F,K1, K2);

P1 = eye(3);
P1 = [P1 zeros(3,1)];
C1 = K1*P1;
M2s = camera2(E);
maxcount=0;
finalP2 =[];
final_pts3d = [];
for i = 1:4
  P2 = M2s(:,:,i);
  C2 = K2*P2;
  pts3d = triangulate(C1, pts1, C2, pts2);
  depths = pts3d(:,3);
  count = sum(depths > 0);
  disp(count);
  if count >= maxcount
    finalP2 = P2;
    final_pts3d = pts3d;
    maxcount = count;
  endif
endfor
scatter3(final_pts3d(:,1), final_pts3d(:,2), final_pts3d(:,3),'filled');
R1 = eye(3);
t1 = zeros(3,1);
R2 = finalP2(:,1:3);
t2 = finalP2(:,4);
save('../data/extrinsics.mat', 'E','R1','R2','t1','t2');
