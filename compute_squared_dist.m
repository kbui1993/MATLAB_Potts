%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function computes the fidelity term matrix of the Potts model.
%Input:
%   g: image
%   means:  matrix of mean intensities, where number of rows correspond to
%           number of clusters
%Output:
%   f: each row i corresponds to g-c_i, where c_i is the row vector of means.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = compute_squared_dist(g,means)

    %obtain size of image
    [M,N,C] = size(g);
    
    %reshape each image of a channel into a vector
    pixels = reshape(g,M*N,C);
    
    %get number of clusters
    K = size(means,1);
    
    %preinitialize
    f = zeros(K,M,N);
    
    %compute fidelity
    for i = 1:K
        mu = means(i,:);
        f(i,:,:) = reshape(sum(0.5*(pixels-mu).^2,2),M,N);
    end
end