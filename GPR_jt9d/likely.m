function likely = likely(x, y, theta, noise)
K = kernel(x,x,theta);
L = chol(K+noise*eye(size(x,1)),'lower');
alpha = L.'\(L\y);
likely = -0.5*y.'*alpha-sum(log(diag(L)));

