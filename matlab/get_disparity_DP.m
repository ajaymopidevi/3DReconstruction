function dispM = get_disparity_DP(im1, im2)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

sz1 = size(im1);
sz2 = size(im2);
disp(sz1);
disp(sz2);
im1 = im2double(im1);
im2 = im2double(im2);

Cost = zeros(sz1(2),sz1(2));
occl_cost = 0.0009;
Idx = zeros(sz1(2),sz1(2));
dispMleft = zeros(sz1(1), sz1(2));
dispMright = zeros(sz1(1), sz1(2));
for y=1:sz1(1)
  for i=2:sz1(2)
    Cost(i,1) = i*occl_cost;
  endfor
  
  for j=2:sz1(2)
    Cost(1,j) = j*occl_cost;
  endfor
  for i=2:sz1(2)
    for j=2:sz1(2)
      [~,index] = min([Cost(i-1,j-1) + (im1(y,i)-im2(y,j))**2,
                         Cost(i-1,j) + occl_cost,
                         Cost(i,j-1) + occl_cost]);
      Idx(i,j) = index;
    endfor
  endfor
  
  i = sz1(2);
  j = sz1(2);
  while(i~=1 && j~=1)
    switch(Idx(i,j))
      case 1
        dispMleft(y,i) = abs(i-j);
        dispMright(y,j) = abs(i-j);
        i = i-1;
        j=j-1;
      case 2
        dispMleft(y,i) = 0;
        i = i-1;
      case 3
        dispMright(y,j) = 0;
        j = j-1;
    end
  end
  disp(y);
endfor

dispM = dispMleft;
      
  
end