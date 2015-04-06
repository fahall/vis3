function [ Rs, ts ] = find_rotation_translation( E )
% Find rotation and translation given E
%
% From Piazza:
%
% When you use SVD to get E=USV', there's an inherent ambiguity in 
% SVD where the signs of corresponding vectors in U (u1, u2, u3) and 
% V (v1, v2, v3) are unknown. For example, if you change u1 -> - u1 
% and v1 -> - v1, this is another valid decomposition of E. 
% Changing the signs of corresponding vectors does not affect E or 
% the validity of the decomposition, but it does affect t and R. 
% If you use all possible decompositions, this will inform you all 
% possible t's and R's. If you do the math, you can determine exactly 
% which decompositions will lead to different values of t and R. 
% If you just try all the decompositions, you should see that certain 
% decompositions will result in the same t's and R's.

% Update: I forgot to mention that to find all the possible R's, you 
% also have to take advantage of the fact that S is 
% diag(1,1,0) * some_scale. This means that there are additional valid 
% decompositions where you negate u3 or v3, but not both. The fact that 
% you can do this will not come across in the math if you solve for R, 
% because in the general case of SVD this is not guaranteed. But because 
% we know that the third diagonal value is 0 (and you can verify by 
% printing S in your code), there are these additional decompositions 
% that you must consider.

[U, S, V] = svd(E);

Us = {U, [-U(:, 1),  U(:, 2),  U(:, 3)], ...
         [ U(:, 1), -U(:, 2),  U(:, 3)], ...
         [ U(:, 1),  U(:, 2), -U(:, 3)], ... %
         [-U(:, 1), -U(:, 2),  U(:, 3)], ...
         [ U(:, 1), -U(:, 2), -U(:, 3)], ...
         [-U(:, 1),  U(:, 2), -U(:, 3)], ...
         [-U(:, 1), -U(:, 2), -U(:, 3)], ... %
         [ U(:, 1),  U(:, 2),  U(:, 3)], ... %
         [-U(:, 1),  U(:, 2),  U(:, 3)], ... %
         [ U(:, 1), -U(:, 2),  U(:, 3)], ...
         [ U(:, 1),  U(:, 2), -U(:, 3)], ...
         [-U(:, 1), -U(:, 2),  U(:, 3)], ... %
         [ U(:, 1), -U(:, 2), -U(:, 3)], ...
         [-U(:, 1),  U(:, 2), -U(:, 3)], ...
         [-U(:, 1), -U(:, 2), -U(:, 3)]};

Vs = {V, [-V(:, 1),  V(:, 2),  V(:, 3)], ...
         [ V(:, 1), -V(:, 2),  V(:, 3)], ...
         [ V(:, 1),  V(:, 2), -V(:, 3)], ... %
         
         [-V(:, 1), -V(:, 2),  V(:, 3)], ... %
         [ V(:, 1), -V(:, 2), -V(:, 3)], ...
         [-V(:, 1),  V(:, 2), -V(:, 3)], ...
         [-V(:, 1), -V(:, 2), -V(:, 3)], ...
         [ V(:, 1),  V(:, 2), -V(:, 3)], ... %
         [-V(:, 1),  V(:, 2), -V(:, 3)], ... %
         [ V(:, 1), -V(:, 2), -V(:, 3)], ...
         [ V(:, 1),  V(:, 2),  V(:, 3)], ...
         [-V(:, 1), -V(:, 2), -V(:, 3)], ... %
         [ V(:, 1), -V(:, 2),  V(:, 3)], ...
         [-V(:, 1),  V(:, 2),  V(:, 3)], ...
         [-V(:, 1), -V(:, 2),  V(:, 3)]};

% the sign of R is unknown
Us = [Us, cellfun(@(x) x*(-1), Us,'un', 0)]; 
Vs = [Vs, cellfun(@(x) x*(-1), Vs,'un', 0)];

R_ninety = [[0, -1, 0]; [1, 0, 0]; [0, 0, 1]];

for i = 1:length(Us)
    % the sign of t is also unknown, but this is included in the variations above
    ts{i} = Us{i}(:, 3);
    
    % transpose is equal to inverse for U because it's unitary
    % and for R_ninety because I checked
    % note: V = R' U R_ninety'
    % so R = (V * inv(R_ninety') * inv(U))' = (V * R_ninety * U')'
    Rs{i} = (Vs{i} * R_ninety * Us{i}')';
end


end

