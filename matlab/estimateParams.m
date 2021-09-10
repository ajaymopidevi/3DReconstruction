function [K, R, t] = estimateParams(P)
  M = P(:,1:3);
  [q,r] = qr(M);
  R = inv(q);
  K = inv(r);
  D = zeros(3,3);
  D(1,1) = sign(K(1,1));
  D(2,2) = sign(K(2,2));
  D(3,3) = sign(K(3,3));
  K = K*D;
  R = inv(D)*R;
  t = inv(K)*P(:,4);
  %K = K./K(3,3);
  
end
