function [ points_3d, err ] = find_3d_points( P1, P2, pts )
% find the 3D points corresponding to P1 and P2
% we assume x1 = P1 * X, and x2 = P2 * X
% where X = (X, Y, Z, W) in the world
% and x1 and x2 are corresponding [x, y] pairs in each image

points_3d = zeros(size(pts, 1), 3);
% assert pts is column-wise

% I'm lazy so I wrote this as a for-loop for each point pair
% See section 1.4.3 Triangulation for formula
for i = 1:size(pts, 1)
    x1 = pts(i, 1);
    y1 = pts(i, 2);
    x2 = pts(i, 3);
    y2 = pts(i, 4);
    
    % XYZ terms
    A = ...
    [P1(3, 1:3) * x1 - P1(1, 1:3); ...
     P1(3, 1:3) * y1 - P1(2, 1:3); ...
     P2(3, 1:3) * x2 - P2(1, 1:3); ...
     P2(3, 1:3) * y2 - P2(2, 1:3)];
    
    % W term
    b = ...
     [-P1(3, 4) * x1 + P1(1, 4); ...
      -P1(3, 4) * y1 + P1(2, 4); ...
      -P2(3, 4) * x2 + P2(1, 4); ...
      -P2(3, 4) * y2 + P2(2, 4);];
    
    % Assume W=1 and solve
    X = A\b;
    points_3d(i, :) = X';
end

% Now we have XYZ world points
% We transform these back into image space and calculate the error
% First, add back in W
hom_pts_3d = [points_3d, ones(size(points_3d, 1), 1)]';
x1_p = (P1 * hom_pts_3d)';
x2_p = (P2 * hom_pts_3d)';

% Next divide by w
x1_p = [x1_p(:, 1) ./ x1_p(:, 3), x1_p(:, 2) ./ x1_p(:, 3)];
x2_p = [x2_p(:, 1) ./ x2_p(:, 3), x2_p(:, 2) ./ x2_p(:, 3)];

% Finally, square the difference and sum
e1 = mean(sqrt(sum((pts(:, 1:2) - x1_p).^2, 2)));
e2 = mean(sqrt(sum((pts(:, 3:4) - x2_p).^2, 2)));

err = mean([e1, e2]);

end

