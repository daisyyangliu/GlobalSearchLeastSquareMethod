%% model

function dy=M2parsolsbc1(t,y,x,XX0)
phi=3/2;sp=0.001;se=0.98;
taue=1/4;eta2=0.3;taua=5/12;r2=12/5;
beta1=x(1);sigma1=x(2);laa=x(3);
%N=408409; Tp=0.001091991;%%%%%%%%countryB
%N=85950; Tp=0.006356011;%%%%%%%%countryA
N=327304; Tp=0.007741268;%%%%%%%%countryC
E0=x(4);
A0=(Tp-sp)*N/(se-sp);
S0=N-x(4)-A0;
I0=0;
XX0=[S0 E0 A0 I0]; 
%%%%%%%% S=y1,E=y2,A=y3,I=y4%%%%%%%%%%%%%%%
dy=zeros(4,1);
dy(1)=laa-y(1)*beta1*(y(4)+sigma1*y(3))-phi*y(1);...
dy(2)=y(1)*beta1*(y(4)+sigma1*y(3))-1/taue*y(2)-phi*y(2);
dy(3)=(1-eta2)*1/taue*y(2)+1/taua*y(4)-phi*y(3);
dy(4)=eta2/taue*y(2)-1/taua*y(4)-r2*y(4);

