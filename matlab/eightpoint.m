function F = eightpoint(pts1, pts2, M)
% eightpoint algorithm:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

N = size(pts1,1);
A = zeros(N,9);

for i=1:N
  x = pts1(i,1)/M;
  y = pts1(i,2)/M;
  u = pts2(i,1)/M;
  v = pts2(i,2)/M;
  
  A(i,:) = [u*x, u*y, u, v*x, v*y, v, x, y, 1];
  
end


[U,S,V] = svd(A);


F=V(:,end);
F = reshape(F,[3,3]);
[U,S,V] = svd(F);
S(3,3)=0;

F=U*S*V';


T = [1/M, 0, 0; 0, 1/M, 0; 0, 0, 1/M];
F = T'*F*T;

F = refineF(F,pts1, pts2);
end 