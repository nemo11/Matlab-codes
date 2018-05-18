clc; close all; clear all;

dt = 0.01;

%% Unicycle Model
sys = ICtSystem(...
    'StateEquation', @(t,x,u,varargin) [
    u(1)*cos(x(3));
    u(1)*sin(x(3));
    u(2)],...
    'nx',3,'nu',2 ...
);

sys.initialCondition = {[0;0;0]};

point = [5;0] ;

sys.controller = UniGoToPoint(point);

va = VirtualArena(sys,...
    'StoppingCriteria'  , @(t,as)t>70,...
    'DiscretizationStep', dt,...
    'PlottingStep'      , 1, ...
    'StepPlotFunction'  , @ex01StepPlotFunction ...
    );

log = va.run();