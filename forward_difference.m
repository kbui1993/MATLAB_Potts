%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function computes the forward difference operator to assist with the
%computation of the total variation term.
%Input:
%   M: height of image
%   N: width of image
%Output:
%   FD: forward difference operator for M x N image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FD = forward_difference(M,N)

    %obtain the indices for x_direction and y_direction FD matrices
    row = (1:M*N)';
    dat = ones(M*N,1);
    col = transpose(reshape((1:M*N),N,M));
    col_xp = [col(:,2:(N)),col(:,(N))];
    col_yp = [col(2:(M),:); col(M,:)];
    
    %FD matrix for x direction
    FD1 = sparse(row,reshape(col_xp.', 1,[]),dat, M*N, M*N)-...
        sparse(row,reshape(col.', 1,[]),dat, M*N, M*N);
    
    %FD matrix for y direction
    FD2 = sparse(row,reshape(col_yp.', 1,[]),dat, M*N, M*N)-...
        sparse(row,reshape(col.', 1,[]),dat, M*N, M*N);
    
    %concatenate
    FD = [FD1; FD2];
end
