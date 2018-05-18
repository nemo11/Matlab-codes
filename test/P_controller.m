%% Proportional controller
clc; close all; clear all;

Kp  = 1; % Parameter unknown by the controller
sys = ICtSystem(...
    'StateEquation', @(t,x,u,varargin)[
    Vr*cos(u(1));
    Vr*sin(u(1));
    -Vr*cos(u(1)-x(4));
    -Vr*sin(u(1)-x(4))/x(3)],...
    'nx',4,'nu',1);
sys.initialCondition = pi/4;

sys.controller = Proportional();
sys.controller.initialCondition = [10;0];

va = VirtualArena(sys,...
    'StoppingCriteria'  , @(t,sysList)t>30,...
    'DiscretizationStep', 0.1,...
    'PlottingStep'      , 1 ...
    );

log = va.run();