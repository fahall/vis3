function [ ] = plot_3d( points, t2 )
% This is a 3d plot wrapper function
X = points(:, 1);
Y = points(:, 2);
Z = points(:, 3);
C = Z;

c1 = [0, 0, 0]';
c2 = c1 - t2;
%c2 = c1;
scatter3(X(:), Y(:), Z(:), 20, C(:), 'o'); 
hold on;
scatter3([c1(1), c2(1)], [c1(2), c2(2)], [c1(3), c2(3)], 30, 'filled');
colormap(hot); colorbar; 
xlabel('X Coordinate'); 
ylabel('Y Coordinate'); 
zlabel('Height');

hold off;

end

