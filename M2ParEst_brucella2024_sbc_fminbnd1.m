clear 
clc
format shortEng
format long
%% Real data
ID=[0.006356011 0.007124382 0.00483842];%%%%%%%%%%%%%contry A
%%  Define Optimization Problem
problem=createOptimProblem('fmincon', ...
    'objective', @M2LS_min, ...
    'x0',ones(1,4),...
    'lb', [ 0.00000001     0.09        5000                   100    ],...
    'ub',[  0.000005      1          40000                 1000      ], ...
    'options',optimoptions('fmincon',...
    'OutputFcn', @curvefittingPlotIterates,...
    'Display','none'))
%% solve
gs = GlobalSearch('Display', 'iter');
[x,fval] = run(gs, problem)
save('parameters1','x');
%%
sp=0.001;se=0.98;
N=85950; Tp=0.006356011;
E0=x(4);
A0=(Tp-sp)*N/(se-sp);
S0=N-x(4)-A0;
I0=0;
XX0=[S0 E0 A0 I0]; 
[T,y]=ode45(@M2parsolsbc1,[0:1:2],XX0,[],x);
testpos=(sp*y(:,1)+sp*y(:,2)+se*y(:,3)+se*y(:,4))./(y(:,1)+y(:,2)+y(:,3)+y(:,4));
ID=[0.006356011 0.007124382 0.00483842];


figure(1)
plot(T,testpos,'r-',0:2,ID,'ro');
title('(a)')
xlabel('Year');ylabel('T_p')
ax = gca; % 获取当前坐标轴对象
set(ax,'XTick',0:2); % 设置横坐标刻度为从 1 到 3
set(ax,'XTickLabel',{'2021','2022','2023'}); % 设置横坐标标签为对应的年份
hold on
saveas(gcf, 'contryA.fig', 'fig')


