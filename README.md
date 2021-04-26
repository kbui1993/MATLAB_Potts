# MATLAB_Potts
This is a MATLAB implementation of the algorithm that solves a convex relaxation of Potts model discussed in 
"A Convex Relaxation Approach for Computing Minimal Partitions" by Pock et al. It is adapted from the code
at https://github.com/VLOGroup/pgmo-lecture. 

If you're using this code for your research, please cite Pock et al.'s paper.
```
@inproceedings{pock2009convex,
  title={A convex relaxation approach for computing minimal partitions},
  author={Pock, Thomas and Chambolle, Antonin and Cremers, Daniel and Bischof, Horst},
  booktitle={2009 IEEE Conference on Computer Vision and Pattern Recognition},
  pages={810--817},
  year={2009},
  organization={IEEE}
}
```

To run a demo, run one of the following scripts:
1. script1.m
2. script2.m
3. script3.m

The general function to apply Potts model to an image is main_pott.m, which asks for the following arguments:
  -f: image
  -K: number of partitions/clusters
  -lambda: fidelity parameter
  -maxit: maximum number of iterations