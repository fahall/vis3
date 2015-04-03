function [ err ] = f_residual_error( F, pts1, pts2 )
%Points should be in HOMOGENEOUS coordinates

% For each corresponding pair of points, 
% compute the epipolar line given by F and one of the points
lines1 = normalizeLine(F * pts1')';

%F is computed to move from im1 pts to im2 lines. 
%F' moves from im2 pts to im1 lines.
lines2 = normalizeLine(F' * pts2')';

%find the distance between the computed epipolar lines and the actual corresponding
%points from the other image.

%get distance
%Formula from http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/BEARDSLEY/node2.html
e1 = sum(pts2 .* lines1, 2);
e2 = sum(pts1 .* lines2, 2);

assert(size(e1, 2) == 1);

%square it
e1 = e1 .* e1;
e2 = e2 .* e2;

%get avg
err = mean(e1) + mean(e2);


end

