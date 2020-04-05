fid = fopen('inp2.BTC','w');

N = 3000;
alt = 10000*rand(N,1);
dtamb = -40+80*rand(N,1);
%XM = 0.8*rand(N,1);
XM = zeros(N,1);
ZXN_HPC = 0.6+0.4*rand(N,1);
delta2 = ((1-0.0065*alt/288.15).^5.2561) ...
            .*((1+0.2*XM.*XM).^3.5);
%PWX = (-3000+6000*rand(N,1)).*(ZXN_HPC.^3).*delta2;
PWX = zeros(N,1);

for i=1:N
  
  fprintf(fid,'[Single Data]\n');
  fprintf(fid,'beta_HPC = 0.5\n');
  fprintf(fid,'beta_HPT = 0.5\n');
  fprintf(fid,'ZT4 = 1450\n');
  fprintf(fid,['alt = ',num2str(alt(i)),'\n']);
  fprintf(fid,['dtamb = ',num2str(dtamb(i)),'\n']);
  fprintf(fid,['XM = ',num2str(XM(i)),'\n']);
  fprintf(fid,['ZXN_HPC = ',num2str(ZXN_HPC(i)),'\n']);
  fprintf(fid,['PWX = ',num2str(PWX(i)),'\n']);
  fprintf(fid,'[Calculate]\n');

end



