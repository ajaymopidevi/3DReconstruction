function dispM = get_disparity(im1, im2)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
%
%	Algorithm:
%		1. For every pixel (x,y), consider a patch of size windowSize x windowSize
%		2. Corresponding pixel for (x,y) will be (x+d,y). Calculate dissimalrity
%		   scores of patches (x+d,y) w.r.t (x,y) for all possible d
%		3. Find the lest dissimilar patch to (x,y)
%

windowSize = 3;
maxDisp = 20;

sz1 = size(im1);
sz2 = size(im2);

im1 = im2double(im1);
im2 = im2double(im2);

w = floor(windowSize/2);
xstart = w+1;
xend = sz1(2) - w;

ystart = w+1;
yend = sz1(1) -w;
dispM = zeros(sz1(1), sz1(2));

for y=ystart:yend
  for x= xstart:xend
    %For every pixel (x,y), consider a patch of size 2w+1 x 2w+1
	im1_patch = im1(y-w:y+w,x-w:x+w);
    disparity = ones(xend-xstart+1,1)*Inf;
    
	%Corresponding pixel for (x,y) will be (x+d,y)
	%Calculate the dissimilarity scores for all d
	for idx = xstart:xend
      im2_patch = im2(y-w:y+w, idx-w:idx+w);
      diff = sum(sum((im2_patch - im1_patch).**2));
      disparity(idx) = diff;
      
    endfor
    %Find the lease  dissimilar patch to (x,y)
	[v,i] = min(disparity);
    if v<= maxDisp
      dispM(y,x) = abs(i-x);
    endif
    
  endfor
  disp(y);
endfor
