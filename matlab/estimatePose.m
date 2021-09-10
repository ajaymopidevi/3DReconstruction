function [P] = estimatePose(X,x)
  N = size(X,2);
  A = zeros(2*N,12);
  j=1;
  for i=1:N
    A(j,:) = [X(1,i), X(2,i), X(3,i), 1, 0 ,0 , 0, 0, -x(1,i)*X(1,i), -x(1,i)*X(2,i), -x(1,i)*X(3,i), -x(1,i)];
    
    A(j+1,:) = [0, 0, 0, 0, X(1,i), X(2,i), X(3,i), 1, -x(2,i)*X(1,i), -x(2,i)*X(2,i), -x(2,i)*X(3,i), -x(2,i)];
    j = j+2;
  endfor
  
  [U,S,V] = svd(A);
  P = V(:,end);
  P = reshape(P, [3,4]);
end
