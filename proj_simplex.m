%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function performs simplex projection on each column of a matrix.
%Input:
%   x: matrix
%Output:
%   proj_x: matrix of x whose columns are projected to a simplex
function proj_x = proj_simplex(x)

    %obtain size of matrix
    s = size(x);
    
    %get number of clusters
    K = s(1);
    
    %simplex projection
    k = linspace(1,K,K);
    x_s = -sort(-x,1);
    t = (cumsum(x_s, 1)-1)./transpose(k);
    mu = max(t);
    proj_x = max(0, x-mu);
end