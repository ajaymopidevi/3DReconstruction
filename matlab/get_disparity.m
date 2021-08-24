function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

sz1 = size(im1);
sz2 = size(im2);
disp(sz1);
disp(sz2);
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
    im1_patch = im1(y-w:y+w,x-w:x+w);
    disparity = ones(xend-xstart+1,1)*Inf;
    %disp(size(disparity));
    for idx = xstart:xend
      im2_patch = im2(y-w:y+w, idx-w:idx+w);
      %disp(sum(sum(im2_patch)));
      diff = sum(sum((im2_patch - im1_patch).**2));
      disparity(idx) = diff;
      %disparity(idx) = disparity(idx)**2;
      
    endfor
    [v,i] = min(disparity);
    if v<= maxDisp
      dispM(y,x) = abs(i-x);
    endif
    
  endfor
  disp(y);
endfor
