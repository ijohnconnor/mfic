clc; clear; close all;

%% �������� �����������
detection_impulse  =  dlmread('scen1\detection_impulse1.txt');


%% ������������ ��������� ����
target  =  define_target_impulse_dopler(160, 1, detection_impulse, 'draw');
