function [ pts_normalized, T ] = normalize_pts( pts )
%NOT WORKING ... WHY?
%convert to homogeneous coordinates
pts = horzcat(pts, ones(length(pts), 1));

%get mean point
mPts = mean(pts);

t = [ 1, 0, -mPts(1,1);
      0, 1, -mPts(1,2);
      0, 0, 1];
            
s = eye(3);
for i = 1:2            
    scale = 1;
    gap = max(pts(:,i)) - min(pts(:,i));

    if gap ~= 0
        scale = scale / gap;
    end
    
    s(i,i) = scale;
end

T = t * s;
T = T / T(3,3);

nPts= pts * T;

%correct for change in 3
w = repmat(nPts(:,3), [1, 3]);
pts_normalized = nPts ./ w;


end

