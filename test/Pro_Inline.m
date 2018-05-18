clc; close all; clear all;

dt = 0.01;

kp =1;
V=2;

X = input('Initial X: ');
Y = input('Initial Y: ');
theta = input('Initial Angle: ');

a = input('Target X: ');
b = input('Target Y: ');
%% Unicycle Model
sys = ICtSystem(...
    'StateEquation', @(t,x,u,varargin) [
    V*cos(x(3));
    V*sin(x(3));
    u(1)],...
    'nx',3,'nu',1 ...
    );

sys.controller = IController(@(t,x)(kp*(atan2((b - x(2)),(a - x(1))) - x(3))));

sys.initialCondition = {[X;Y;theta]};

va = VirtualArena(sys,...
    'StoppingCriteria'  , @(t,x,sysList)sqrt((sys.x(1)-a)*(sys.x(1)-a) + (sys.x(2)-b)*(sys.x(2)-b))<=0.1,...
    'DiscretizationStep', dt,...
    'PlottingStep'      , 1, ...
    'StepPlotFunction'  , @ex01StepPlotFunction ...
    );


log = va.run();
