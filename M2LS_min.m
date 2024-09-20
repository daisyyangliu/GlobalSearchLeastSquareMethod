
function dis = M2LS_min(x)
%% LS_min: Least-square method
%inputs:parameters, data, intial guess
%outputs:  residual (a number)
sp=0.001;se=.98;
%N=408409; Tp=0.001091991;%%%%%%%%countryB
%N=85950; Tp=0.006356011;%%%%%%%%countryA
N=327304; Tp=0.007741268;%%%%%%%%countryC
E0=x(4);
A0=(Tp-sp)*N/(se-sp);
S0=N-x(4)-A0;
I0=0;
XX0=[S0 E0 A0 I0]; 
[T,y]=ode45(@M2parsolsbc1,[0:1:2],XX0,[],x);
testpos=(sp*y(:,1)+sp*y(:,2)+se*y(:,3)+se*y(:,4))./(y(:,1)+y(:,2)+y(:,3)+y(:,4));
%ID=[0.006356011 0.007124382 0.00483842 ];
%ID=[0.001091991 0.004337963 0.002845337]; %contry B
ID=[0.007741268 0.011307275 0.008534458]; %contry C
dis = 0.0001*norm((testpos-ID').^2);

