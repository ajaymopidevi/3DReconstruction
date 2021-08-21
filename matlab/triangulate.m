function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

N = size(pts1,1);
A = zeros(4);
for i=1:N
  x1 = pts1(i,1);
  y1 = pts1(i,2);
  x2 = pts2(i,1);
  y2 = pts2(i,2);
  A(1,:) = P1(3,:).*y1 - P1(2,:);
  A(2,:) = P1(1,:) - P1(3,:).*x1;
  
  A(3,:) = P2(3,:).*y2 - P2(2,:);
  A(4,:) = P2(1,:) - P2(3,:).*x2;
  [U,S,V] = svd(A);
  
  pt3d = V(:,end);
  pt3d = pt3d./pt3d(4,1);
  pts3d(i,:) = [pt3d(1), pt3d(2), pt3d(3)];
end
