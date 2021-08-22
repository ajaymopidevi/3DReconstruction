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
