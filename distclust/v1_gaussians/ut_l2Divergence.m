% unit test for L2 Divergence between 2 distributions

close all

% Test 1 : 1D
%%%%%%%%%%%%%
fprintf('Test 1\n======\n');
N = 500;
X = rand(N, 1);
Y = rand(N, 1) + 0.5;
l2 = l2Divergence(X, Y);
fprintf('Estimated L2: %f, true: 1.00\n', l2);

% Test 2 : 1D
%%%%%%%%%%%%%
fprintf('\nTest 2\n======\n');
dims = 2;
N = 1000;
X = rand(N, dims);
Y = rand(N, dims) + 0.5;
l2 = l2Divergence(X, Y);
fprintf('Estimated L2: %f, true: %f\n', l2, sqrt(2 - 2*(0.5^dims)));

% Test 3: 4D
%%%%%%%%%%%%%
fprintf('\nTest 3\n======\n');
N = 100;
dims = 10;
X = randn(N, dims);
% Y = randn(N, dims) * diag(1./(1:dims));
Y = randn(N, dims);
Z = 10 + randn(N, dims);
l2XY = l2Divergence(X, Y);
l2XZ = l2Divergence(X, Z);
l2YZ = l2Divergence(Y, Z);
fprintf('L2(X,Y): %f, L2(X,Z): %f, L2(Z,Y): %f\n', l2XY, l2XZ, l2YZ);
figure;
plot(X(:,1), X(:,2), 'rx', Y(:,1), Y(:,2), 'bo', Z(:,1), Z(:,2), 'gs');

