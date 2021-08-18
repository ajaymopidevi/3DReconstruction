function F = eightpoint(pts1, pts2, M)
% eightpoint algorithm:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

N = size(pts1,1);
A = zeros(N,9);

P1 = pts1./M;
P2 = pts2./M;

for i=1:N
  x = P1(i,1);
  y = P1(i,2);
  u = P2(i,1);
  v = P2(i,2);
  
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