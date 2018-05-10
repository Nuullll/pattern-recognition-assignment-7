function d = recogfun(X,mu,sigma,p)
% recognizing function
% d(X) = X'*W*X + w'*X + w0
mu = reshape(mu,2,1);
W = -inv(sigma)/2;
w = sigma \ mu;
w0 = -0.5*mu' * (sigma \ mu) - 0.5*log(det(sigma)) + log(p);
d = X'*W*X + w'*X + w0;
d = diag(d);
end