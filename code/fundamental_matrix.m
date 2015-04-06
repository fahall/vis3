function [F, res_err] = fundamental_matrix(matches)

%preallocate for speed
pts = cell(1,2);
T = cell(1,2);

%normalize both sets of points individually
for i = [1,3]
    [pts{i}, T{i}] = normalize_pts(matches(:,i:i+1));
end


%change notation for readability
x1 = pts{1}(:,1);
y1 = pts{1}(:,2);
x2 = pts{3}(:,1);
y2 = pts{3}(:,2);
one = ones(length(x1),1);

%build the A Matrix

A = [x1 .* x2, y1 .* x2, x2, x1 .* y2, y1 .* y2, y2, x1, y1, one];

%compute F
[~,~,V] = svd(A, 0);
F = reshape(V(:,9), 3, 3)';
[FU, FS, FV] = svd(F);
S = diag([FS(1,1),FS(2,2), 0]);%enforce rank = 2
F = FU * S * FV';

%remove normalization
F = T{3}' * F * T{1};

%TF = estimateFundamentalMatrix([x1,y1], [x2,y2], 'Method', 'Norm8Point');
%F = TF;
%compute error
res_err = f_residual_error(F, pts{1}, pts{3});
end

