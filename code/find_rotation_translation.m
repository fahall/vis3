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
         [ U(:, 1),  U(:, 2),  U(:, 3)], ...
         [-U(:, 1),  U(:, 2),  U(:, 3)]};

Vs = {V, [-V(:, 1),  V(:, 2),  V(:, 3)], ...
         [ V(:, 1),  V(:, 2), -V(:, 3)], ...
         [-V(:, 1),  V(:, 2), -V(:, 3)]};

R_ninety = [[0, -1, 0]; [1, 0, 0]; [0, 0, 1]];

ts{1} = Us{1}(:, 3);
ts{2} = -Us{1}(:, 3);

for i = 1:length(Us)
    
    % transpose is equal to inverse for U because it's unitary
    % and for R_ninety because I checked
    % note: V = R' U R_ninety'
    % so R = (V * inv(R_ninety') * inv(U))' = (V * R_ninety * U')'
    Rs{i} = (Vs{i} * R_ninety * Us{i}')';
    
%     t1 = ts{i}(1);
%     t2 = ts{i}(2);
%     t3 = ts{i}(3);
%     
%     tx = [0, -t3, t2;
%           t3, 0, -t1;
%          -t2, t1, 0];
%     Es{i} = tx * Rs{i};
end


end

