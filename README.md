# 3DReconstruction

## Sparse Reconstruction using stereo images
![sparse_reconstruction](https://user-images.githubusercontent.com/28349806/130352646-57c3c398-dffa-4ad6-89d0-ee69f8ba55d1.png)

1. Estimate Fundamental Matrix F
    * Use SVD decomposition to get F
    * Ensure rank of 2 by forcing the Diagonal matrix of F to 0
2. Estimate epipolar Correspondences
    * For every point p, find l' = Fp 
    * For every y in a range, find (x',y) that fits the line equation l'
    * Considering patches around (x,y) in I<sub>1</sub> and (x,y') in I<sub>2</sub> and find the dissimilarity
    * Patch around (x,y') with minimum dissimilarity is corresponding point for (x,y)
3. Calculate Essential Matrix
    * E = K<sub>2</sub><sup>T</sup> * F * K<sub>1</sub>
4. Estimate 3D points using Triagulation
    * Estimate 4 possible camera matrices (M) using E
    * Estimate 3D locations using M
    * Correct configuration of camera matrix M has depth of all 3D locations > 0 



## Dense Reconstruction using stereo images

1. Disparity Map Generation
   * For every pixel (x,y), corresponding pixel will be (x+d,y). Calculate dissimalrity scores for all possible d
   * Find the least dissimilar patch to (x,y)
2. Depth = ((c1 - c2)*f)./disparity_map <br />
      &emsp; c1 - center of left camera<br />
      &emsp; c2 - center of right camera<br />
      &emsp; f - focal length<br />
      
# Block based Disaprity Map
* For every pixel (x,y), consider a patch of size windowSize x windowSize
* Corresponding pixel for (x,y) will be (x+d,y). Calculate dissimalrity scores of patches (x+d,y) w.r.t (x,y) for all possible d 
* Find the least dissimilar patch to (x,y)

Disparity Map           |  Depth Map
:-------------------------:|:-------------------------:
![](https://github.com/ajaynarasimha/3DReconstruction/blob/main/output/disparity_windowBased.png)  |  ![](https://github.com/ajaynarasimha/3DReconstruction/blob/main/output/depth_windowBaed.png)

# Dynammic Programming based Disparity Map


Disparity Map           |  Depth Map
:-------------------------:|:-------------------------:
![](https://github.com/ajaynarasimha/3DReconstruction/blob/main/output/disparity_DP.png)  |  ![](https://github.com/ajaynarasimha/3DReconstruction/blob/main/output/depth_DP.png)
