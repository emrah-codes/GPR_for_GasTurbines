function optimTheta

load('jt9d.mat');

convRange = jt9d(17,:)' == 1;

dTamb = jt9d(1,convRange)';
MN = jt9d(2,convRange)';
Pamb = jt9d(3,convRange)';
FAR = jt9d(4,convRange)';

GrossThrust = jt9d(5,convRange)';
BPR = jt9d(6,convRange)';
FuelFlow = jt9d(7,convRange)';
Fan_PRc = jt9d(8,convRange)';
Fan_Mfc = jt9d(9,convRange)';
LPC_PRc = jt9d(10,convRange)';
LPC_Mfc = jt9d(11,convRange)';
HPC_PRc = jt9d(12,convRange)';
HPC_Mfc = jt9d(13,convRange)';
LPT_PRc = jt9d(14,convRange)';
LPT_Mfc = jt9d(15,convRange)';
HPT_PRc = jt9d(16,convRange)';
N_HP = jt9d(18,convRange)';
N_LP = jt9d(19,convRange)';

TrainRange = 1:2500;

x = [dTamb(TrainRange) MN(TrainRange) Pamb(TrainRange) FAR(TrainRange)];
y = GrossThrust(TrainRange);

initGuess = std(x);
noise = 1e-3;

fun = @(theta) optlikely(x,y,[1 theta],noise);

options = optimset('MaxFunEvals',100000,...
                   'MaxIter',100000,...
                   'PlotFcns',@optimplotfval,...
                   'TolFun',1);
theta = fminsearch(fun,initGuess,options);
disp(['optim theta: ' num2str(theta)])

K = kernel(x,x,[1 theta]);
L = chol(K+noise*eye(size(x,1)),'lower');
alpha = L.'\(L\y);

save('theta.mat','theta');
save('alpha.mat','alpha');
save('x.mat','x');

function nlikely = optlikely(x, y, theta, noise)
nlikely = -likely(x, y, theta, noise);


