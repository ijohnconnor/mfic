clc; clear; close all;

%% Импульсы обнаружения
detection_impulse  =  dlmread('scen1\detection_impulse1.txt');


%% Формирование импульсов цели
target  =  define_target_impulse_dopler(160, 1, detection_impulse, 'draw');
