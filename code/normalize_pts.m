function [ nPts, T ] = normalize_pts( pts )
%convert to homogeneous coordinates
pts = horzcat(pts, ones(length(pts), 1));

%get mean point
mPts = mean(pts);

t = [ 1, 0, -mPts(1,1);
      0, 1, -mPts(1,2);
      0, 0, 1];

scale = sqrt(2*length(pts) / (sum((pts(:, 1) - mPts(1, 1)).^2 ...
                                + (pts(:, 2) - mPts(1, 2)).^2)));

s = diag([scale, scale, 1]);

T = s * t;
assert(T(3, 3) == 1)

nPts = (T * pts')';
assert(all(nPts(:, 3) == ones(length(nPts), 1)))

end

