function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
%	Algorithm:
%		1. For every point p, find l' = Fp
%		2. For every y in a range, find (x',y) that fits the line equation l'
%		3. Considering patches around (x,y) in I1 and (x,y') in I2 and find the dissimilarity
%		4. Patch around (x,y') with minimum dissimilarity is corresponding point for (x,y) 

  N = size(pts1,1);
  pts2 = zeros(N,2);
  
  if size(im1,3) ==3
    im1 = im2double(rgb2gray(im1));
  endif
  
  if size(im2,3) ==3
    im2 = im2double(rgb2gray(im2));
  endif
  
  patch_size = 5;
  half_patch_size = floor(patch_size/2);
  range = 10;
  
  h = size(im1,1);
  w = size(im1,2);
  weights = fspecial('gaussian',[patch_size, patch_size], 0.5);

  for i=1:N
    x1 = pts1(i,1);
    y1 = pts1(i,2);
    pt1 = [x1; y1; 1];
    
	%Line equation parameters
	l2 = F*pt1;
    
    patch_im1 = im1(y1 - half_patch_size: y1 + half_patch_size, x1 - half_patch_size:x1 + half_patch_size);
    patch_im1 = patch_im1.*weights;
    xstart = half_patch_size+1;
    xend = w - half_patch_size;
    
    ystart = max(1, y1 - range);
    yend = min(h, y1+range);
    min_diff = Inf;
    for y = ystart:yend
      %ax+by+c=0 -> x = -1/a(by+c)
      x = round(-((l2(2)*y)+l2(3))/l2(1));
      
      if (x<xstart | x>xend)
        continue;
      endif
      patch_im2 = im2(y-half_patch_size:y+half_patch_size, x-half_patch_size:x+half_patch_size);
      patch_im2 = patch_im2.*weights;
      
      diff = pdist2(patch_im1, patch_im2);
      total_diff = sum(diff(:));
      if total_diff < min_diff
        pts2(i,:) =  [x,y];
        min_diff = total_diff;
      endif
            
    endfor
    
  end
end

