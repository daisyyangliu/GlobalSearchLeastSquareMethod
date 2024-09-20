clear 
clc
%format shortEng
%format long


%% Real data
% t=[1 2 3 4];
%ID=[0.006356011 0.007124382 0.00483842];%%%%%%%%%%%%%contry A
%ID=[0.006356011 0.007124382 0.00483842 0.011575666];
%ID=[0.001091991 0.004337963 0.002845337]; %contry B
ID=[0.007741268 0.011307275 0.008534458]; %contry C
%%  Define Optimization Problem
problem=createOptimProblem('fmincon', ...
    'objective', @M2LS_min, ...
    'x0',ones(1,4),...
    'lb', [ 0.0000001     0.01        200000                 100    ],...
    'ub',[   0.00002       1           420000                 7000     ],...
    'options',optimoptions('fmincon',...
    'OutputFcn', @curvefittingPlotIterates,...
    'Display','none'))
%% solve
gs = GlobalSearch('Display', 'iter');
[x,fval] = run(gs, problem)
save('parameters3','x');

%%
N=327304; Tp=0.007741268;%%%%%%%%countryC
sp=0.001;se=0.98;
E0=x(4);
A0=(Tp-sp)*N/(se-sp);
S0=N-x(4)-A0;
I0=0;
XX0=[S0 E0 A0 I0]; 
[T,y]=ode45(@M2parsolsbc1,[0:1:2],XX0,[],x);
testpos=(sp*y(:,1)+sp*y(:,2)+se*y(:,3)+se*y(:,4))./(y(:,1)+y(:,2)+y(:,3)+y(:,4));

figure(1)
plot(T,testpos,'r-',0:2,ID,'ro');
title('(c)')
xlabel('Year');ylabel('T_p')
ax = gca; % 获取当前坐标轴对象
set(ax,'XTick',0:2); % 设置横坐标刻度为从 1 到 3
set(ax,'XTickLabel',{'2021','2022','2023'}); % 设置横坐标标签为对应的年份
hold on
saveas(gcf, 'contryC.fig', 'fig')
