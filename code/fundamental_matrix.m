function [F res_err] = fundamental_matrix(matches)

pts{1} = matches(:,1:2);
pts{2} = matches(:,3:4);


x1 = pts{1}(:,1);
y1 = pts{1}(:,2);
x2 = pts{2}(:,1);
y2 = pts{2}(:,2);
one = ones(length(x1),1);

%now we build the A Matrix

A = [x1 .* x2, y1 .* x2, x2, x1 .* y2, y1 .* y2, y2, x1, y1, one];
[~,~,V] = svd(A, 0);
F = reshape(V(:,9), 3, 3)';
[FU, FS, FV] = svd(F);
FS(3,3) = 0; %enforce rank(FS) = 2
F = FU * FS * FV';
    


end

