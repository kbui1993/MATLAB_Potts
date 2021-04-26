%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function performs l2 norm projection.
%Input:
%   p: vector
%   tau: regularization parameter relating to l2 norm
%Output:
%   proj_p: projected vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function proj_p = proj_inf_l2(p, tau)
    
    %compute l2 norm of p
    norm_p = sqrt(sum(p.^2,1));
    
    %projection
    proj_p = p./max(1, norm_p/tau);
    

end