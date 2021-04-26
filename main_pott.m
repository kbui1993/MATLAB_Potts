%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function directly applies Potts model to an image.
%Input:
%   f: image
%   K: number of clusters
%   lambda: fidelity parameter
%   maxit: maximum number of iterations to solve model
%Output:
%   pwc_f: piecewise-constant approximation of f by Potts model
%   u: matrix where each row, which must be reshaped, corresponds to a
%   cluster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [pwc_f,u] = main_pott(f, K, lambda, maxit)
    %convert to double just in case
    f = double(f);
    
    %obtain size
    [m,n,c] = size(f);
    
    %obtain centroid or mean intensity values via kmeans
    pixels = reshape(f, m*n, c);
    [~, C] = kmeans(pixels, K, 'MaxIter', 1000);
    
    %compute fidelity
    fidel = compute_squared_dist(f,C);
    
    %potts model
    u = potts_tight_pd(lambda*fidel, maxit);
    
    %make into rgb image
    pwc_f = make_rgb(u, C);
end