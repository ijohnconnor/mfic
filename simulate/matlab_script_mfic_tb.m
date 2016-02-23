



%%%%%%%%%%%% Интерфейс %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Выбор действия (режим):
flag_control = 1;  % 0 - генерирование входных воздействий для Test bench
                   % 1 - анализ выходных воздействий 

if (flag_control==0)                   
clear all;
clc;                 
end                 
                   
%% Параметры 
WIDTH_IN = 32; 
WIDTH_OUT = 32; 
LENGTH_IN = 40000;                          % length input signal testbench
LENGTH_OUT = 39000;     
Fs = 10e6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%% Генерирование входных воздействий %%%%%%%%%%%%%%%%%
if (flag_control==0)

    %% Импульсы обнаружения
   detection_impulse  =  dlmread('test_target_impulse\scen1\detection_impulse1.txt'); 
        %% Формирование импульсов цели
   target  =  define_target_impulse_dopler(160, 1, detection_impulse, 'draw');
    
   
    K=8192;
    V=100;
    X=[];
    strobe = [];
    
    for h=1:ceil(length(detection_impulse)/K)
        X = [X;  detection_impulse(K*(h-1)+1:K*h,:);  zeros(V,16)];
        strobe = [strobe;  ones(K,1);  zeros(V,1)]; 
    end
    
    
    %write_sig(X(:,1),  WIDTH_IN, 'in_0.dat');
    %write_sig(X(:,2),  WIDTH_IN, 'in_1.dat');
    %write_sig(X(:,3),  WIDTH_IN, 'in_2.dat');
    %write_sig(X(:,4),  WIDTH_IN, 'in_3.dat');
    %write_sig(X(:,5),  WIDTH_IN, 'in_4.dat');
    %write_sig(X(:,6),  WIDTH_IN, 'in_5.dat');
    %write_sig(X(:,7),  WIDTH_IN, 'in_6.dat');
    %write_sig(X(:,8),  WIDTH_IN, 'in_7.dat');
    %write_sig(X(:,9),  WIDTH_IN, 'in_8.dat');
    %write_sig(X(:,10), WIDTH_IN, 'in_9.dat');
    %write_sig(X(:,11), WIDTH_IN, 'in_10.dat');
    %write_sig(X(:,12), WIDTH_IN, 'in_11.dat');
    %write_sig(X(:,13), WIDTH_IN, 'in_12.dat');
    %write_sig(X(:,14), WIDTH_IN, 'in_13.dat');
    %write_sig(X(:,15), WIDTH_IN, 'in_14.dat');
    %write_sig(X(:,16), WIDTH_IN, 'in_15.dat');
    %write_sig(strobe, 1, 'strobe.dat');    
    
    

    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%% Чтение выходов %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (flag_control==1)
    

    
   delay_module = 5;
   
   
   sig_out_rtl = target.amplitude;
   tt = 1:length(sig_out_rtl);
   sig_out_rtl = sig_out_rtl(tt);   
   
   sig_out  = importfile_hex('sig_out.dat' , delay_module, LENGTH_OUT+delay_module);     
   ena_out  = importfile_hex('ena_out.dat' , delay_module, LENGTH_OUT+delay_module);      

   sig_out = sig_out(ena_out==1);
   sig_out = sig_out(tt);

   


   figure(10)
   subplot(2,1,1)
   plot(tt, sig_out_rtl, tt, sig_out)
   title('Выходной сигнал')
   xlabel('отсчеты')
   ylabel('мл разр')
   legend('matlab','rtl')
   grid on

   subplot(2,1,2)
   plot(tt, sig_out-sig_out_rtl)
   title('Выходной сигнал')
   xlabel('отсчеты')
   ylabel('мл разр')
   legend('ошибка')
   grid on 
   
%    subplot(4,1,2)
%    plot(tt, Strobe_signal_line, tt, Strobe_signal_line_rtl)
%    title('Строб выходного сигнала')
%    xlabel('отсчеты')
%    ylabel('мл разр')
%    legend('matlab','rtl')
%    grid on
% 
%    subplot(4,1,3)
%    plot(tt1, count_adaptive, tt1, count_adaptive_rtl)
%    title('Кол-во превышений порога в одном цикле')
%    xlabel('порядковый номер цикла')
%    ylabel('мл разр')
%    legend('matlab','rtl')
%    grid on
% 
%    subplot(4,1,4)
%    plot(tt1, threshold_adaptive, tt1, threshold_adaptive_rtl)
%    title('Величина адаптивного порога')
%    xlabel('порядковый номер цикла')
%    ylabel('мл разр')
%    legend('matlab','rtl')
   grid on

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    















