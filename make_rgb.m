%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function converts the result of Potts model to a piecewise-constant
%image using the pre-determined mean intensities.
%Input:
%   u: output from potts_tight_pd function
%   means: matrix of mean intensities, where number of rows correspond to
%           number of clusters
%Output:
%   u_rgb: piecewise constant image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u_rgb = make_rgb(u, means)

    %obtain size of u
    [M, N, K] = size(u); 
    
    %preinitialize
    u_rgb = zeros(M,N,3);
    
    %compute the piecewise-constant image
    for i=1:K
        mu = means(i,:);
        u_rgb(:,:,1) = u_rgb(:,:,1) + u(:,:,i)*mu(1);
        u_rgb(:,:,2) = u_rgb(:,:,2) + u(:,:,i)*mu(2);
        u_rgb(:,:,3) = u_rgb(:,:,3) + u(:,:,i)*mu(3);
    end
end