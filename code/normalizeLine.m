function [ nLine ] = normalizeLine( line )


assert(size(line, 1) == 3, 'Lines expected to be nx3 matrix');
sLine = line .* line;
mag = sqrt( sLine(1,:) + sLine(2,:));
%Possible bug: the 'w' values are also being divided by the magnitude
%Does this break the assumption of homogeneous coordinates?
nLine = line ./ repmat( mag, 3, 1 );  


end

