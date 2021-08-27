function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).

f = K1(1,1)
c1 = -inv(K1*R1)*(R1*t1);
c2 = -inv(K2*R2)*(R2*t2);

b = norm(c1-c2);
depthM = (b*f)./dispM;
depthM(isnan(depthM))=0;