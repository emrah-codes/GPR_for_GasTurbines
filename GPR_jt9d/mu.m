function [mu] = mu(x,xTarget,theta,alpha)
kstar = kernel(x,xTarget,theta);
mu = kstar.'*alpha;
