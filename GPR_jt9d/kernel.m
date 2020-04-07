function [K] = kernel(a, b, theta)
a = a./repmat(theta(2:end),size(a,1),1);
b = b./repmat(theta(2:end),size(b,1),1);
sqdist = repmat(sum(a.^2,2),1,size(b,1))+ ...
         repmat(reshape(sum(b.^2,2),1,[]),size(a,1),1)-2*a*b.';
K = theta(1)*exp(-0.5*sqdist);