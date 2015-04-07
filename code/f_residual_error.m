function [ err ] = f_residual_error( F, pts1, pts2 )
%Points should be in HOMOGENEOUS coordinates

%find the distance between the computed epipolar lines and the actual corresponding
%points from the other image.

% For each corresponding pair of points, 
% compute the epipolar line given by F and one of the points
lines1 = F * pts1';
mag1 = (lines1(1, :).^2 + lines1(2, :).^2).^0.5;
dist1 = abs(sum(lines1 .* pts2')) ./ mag1;

%F is computed to move from im1 pts to im2 lines. 
%F' moves from im2 pts to im1 lines.
lines2 = F' * pts2';
mag2 = (lines2(1, :).^2 + lines2(2, :).^2).^0.5;
dist2 = abs(sum(lines2 .* pts1')) ./ mag2;

%square it
%get avg
err = mean([mean(dist1.^2), mean(dist2.^2)]);

end

