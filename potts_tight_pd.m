%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function solves the Potts model according to the paper:
%"A Convex Relaxation Approach for Computing Minimal Partitions."
%Input:
%   f: fidelity matrix computed from compute_squared_dist
%   maxit: maximum number of iterations to solve the model
%Output:
%   result: matrix, where each row, which must be reshaped, corresponds to
%   a cluster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = potts_tight_pd(f, maxit)
    [K,M,N] = size(f);
    f1 = permute(f, [3 2 1]);
    f= reshape(f1,M*N,K)';
    
    %number of dual constraints
    KK = K*(K-1)/2;
    
    %primal variables
    u = zeros(K,M*N);
    v = zeros(KK, 2*M*N);
    
    %dual variable
    p = zeros(K,2*M*N);
    q = zeros(KK,2*M*N);
    
    %make gradient operator
    FD = forward_difference(M,N);
    
    %primal/dual step sizes chosen using diagonal preconditioning
    fact = 1.0;
    tau_u = fact*1.0/4.0;
    tau_v = fact*1.0/3.0;
    sigma_p = 1.0/(2.0+K-1)/fact;
    sigma_q = 1.0/fact;
    theta = 1.0;
    
    for it = 1:maxit
        %remember old parameters
        ui = u;
        vi = v;
        
        %primal update
        for i = 1:K
            u(i,:) = u(i,:) - tau_u*(p(i,:)*FD+f(i,:));            
        end
        
        idx = 1;
        
        for i =1:(K-1)
            for j = (i+1):K
                v(idx,:) = v(idx,:)- tau_v*(p(i,:)-p(j,:)-q(idx,:));
                idx = idx+1;
            end
        end
        
        %project u onto simplex
        u = proj_simplex(u);
        
        %overrelaxation
        ui = u+theta*(u-ui);
        vi = v+theta*(v-vi);
        
        %dual update
        for i = 1:K
            p(i,:) = p(i,:) + sigma_p*transpose((FD*transpose(ui(i,:))));
        end
        
        idx = 1;
        for i =1:(K-1)
            for j = (i+1):K
                p(i,:) = p(i,:) + sigma_p*vi(idx,:);
                p(j,:) = p(j,:) - sigma_p*vi(idx,:);
                q(idx,:) = q(idx,:) - sigma_q*vi(idx,:);
                idx = idx+1;
            end
        end
        
        %projection of dual variable
        idx = 1;
        
        for i=1:(K-1)
            for j=(i+1):K
                temp = reshape(q(idx,:),M*N,2)';
                temp = proj_inf_l2(temp, 1.0);
                q(idx,:) = reshape(temp',2*M*N,1)';
                idx = idx +1;
            end
        end
        
        if mod(it,100)==0
            TV = 0;
            for i = 1:K
                TV = TV + p(i,:)*FD*transpose(u(i,:));
            end
            fprintf("iteration %d:  TV = %f \n", it, TV);
        end
        
        
    end
    
    result = reshape(u,K,N,M);
    result = permute(result, [3 2 1]);
end