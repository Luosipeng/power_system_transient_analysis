%% This function is a linear solver 
%Because the function is used to solve a single machine infinite bus system
%and a nine buses system,i'd like to use the direct linear solver.
%%
function [dx,info]= linearsolve(A, b, alg)
    %using direct linear solver to solve the linear equations Ax=b
    if alg=="LU"
       %LU decomposition
       [L, U, P] = lu(A); %P is a permutation matrix used for partial selection of principal components
       %Solving Ly=Pb
       Pb = P * b;%Adjust the right vector according to the permutation matrix
       y = L \ Pb;%Solve the equation Ly=Pb for the triangular matrix
       %Solving Ux = y
       dx = U \ y;% Solving the equation Ux=y for a triangular matrix
       info=0;
    end
end