clc; clear; close;

load('jt9d.mat');
load('alpha.mat');
load('theta.mat');
load('x.mat');

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

Corr = corrMat([dTamb MN Pamb FAR GrossThrust BPR ...
                FuelFlow Fan_PRc Fan_Mfc LPC_PRc ...
                LPC_Mfc HPC_PRc HPC_Mfc N_HP N_LP]);
   
TrainRange = 1:2500;
TestRange = 2501:5000;

xTest = [dTamb(TestRange) MN(TestRange) Pamb(TestRange) FAR(TestRange)];
yTest = GrossThrust(TestRange);

xTrain = [dTamb(TrainRange) MN(TrainRange) Pamb(TrainRange) FAR(TrainRange)];
yTrain = GrossThrust(TrainRange);

GPRmu = mu(x,xTest,[1 theta],alpha);

R2 = 1-sum((yTest-GPRmu).^2)/sum((yTest-mean(yTest)).^2);
disp(['R2: ' num2str(R2)])

errors = abs(yTest-GPRmu);
perErrors = 100*abs(yTest-GPRmu)./abs(yTest);
RMSE = sqrt(mean(errors.^2));
RMSEper = sqrt(mean(perErrors.^2));
MeanE = mean(errors);
MeanEper = mean(perErrors);
MaxE = max(errors);
MaxEper = max(perErrors);

disp(['RMSE: ' num2str(RMSE)])
disp(['MeanE: ' num2str(MeanE)])
disp(['MaxE: ' num2str(MaxE)])

disp(['RMSEper: ' num2str(RMSEper)])
disp(['MeanEper: ' num2str(MeanEper)])
disp(['MaxEper: ' num2str(MaxEper)])

errorMarg = errors>0.01*mean(yTest);

figure
plot(yTest,GPRmu,'b*','MarkerSize',2)
hold on
plot(yTest(errorMarg),GPRmu(errorMarg),'r*','MarkerSize',2)
plot([0.99*min(yTest) 1.01*max(yTest)], ...
  [min(yTest) 1.02*max(yTest)],'k-','LineWidth',0.5)
plot([0.99*min(yTest) 1.01*max(yTest)], ...
  [0.98*min(yTest) 1.0*max(yTest)],'k-','LineWidth',0.5)
xlim([0.99*min(yTest) 1.01*max(yTest)])
ylim([0.99*min(yTest) 1.01*max(yTest)])
legend('GPR prediction', ...
...%'GPR predictions with more than 1 % error', ...
'1 % error interval', ...
'Location','northwest')

figure
XYnames = {'dTamb','MN','Pamb','FAR'};
XY = xTest;
XYtrain = xTrain;
sizeXY = size(XY,2);
for i=1:sizeXY
  for j=1:sizeXY
    if (i>j)
      subplot(sizeXY,sizeXY,j+(i-1)*sizeXY)
      plot(XY(:,j),XY(:,i),'*b','MarkerSize',2)
      hold on
      plot(XYtrain(:,j),XYtrain(:,i),'*g','MarkerSize',2)
      if (i==sizeXY)
        xlabel(XYnames(j));
      end
      if (j==1)
        ylabel(XYnames(i));
      end
      
      plot(XY(errorMarg,j),XY(errorMarg,i),'*r','MarkerSize',2)
      
      axis([min(XY(:,j)) max(XY(:,j)) min(XY(:,i)) max(XY(:,i))])
    end
  end
end

 
 
      

