

clear all;
%close all;

point_sign =  20; % точка от начала сигнала откуда считаем шум
point_noise = 40; % количество точек по шумам

M_strobe = point_noise; % строб по шумам

M = 200 ; % количество стробов по шумам

threshold = 500; % порог
threshold_add = 300; % подставка порога

false_alarm = ceil(0.01*(M*M_strobe)); % вероятность ложной тревоги
step_ad = 10;

step_end = 100;

h0 = waitbar(0,'Please wait...');
%h1 = waitbar(1,'Please wait...');

Nbit = 32;
Vp = 1;

A = 2000/(2^Nbit);

mu_noise = 200/(2^Nbit); % среднее по шумам
sigma_noise = 100/(2^Nbit) ; % сигма, СКО шума

   signal = [ zeros(1,point_sign/4) A*ones(1,point_sign/2) zeros(1,point_sign/4 + point_noise)] ;
  
for step = 1: step_end

    waitbar(step/step_end,h0);
  
     
     
    for m = 1:M       
     %waitbar(m/M,h1);
        
        noise = abs(normrnd(mu_noise,sigma_noise,[1,point_sign + point_noise]));
        signal_noise(:,m) = signal + noise;
        %signal_noise(:,m) = signal;
        S(:,m,step) =     double(uencode(signal_noise(:,m), Nbit, Vp, 'signed')); 
        
        
        Strobe_noise(:,m,step) = [zeros(1,point_sign) ones(1,point_noise)];
    end

 
end
 


% 
%% алгоритм обнаружителя простой
 for step = 1: step_end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %waitbar(step_end/step);

    count = 0;

    for m = 1 : M

        for n = 1 : point_noise
            
            if( S(n + point_sign, m,step)>threshold) 
                count = count + 1;
            end
        end        

    end


    
    
        if  count  > false_alarm
            threshold = threshold + step_ad;
        else
            threshold = threshold - step_ad;
        end

        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
        
  threshold_adaptive(step) =  threshold; 
  count_adaptive(step) =  count; 
        
        
 end
 

%% циклограмма порога

threshold_work = threshold_adaptive + threshold_add; 

for step = 1: step_end
          
    for m = 1:M      
        
        for n = 1:(point_sign + point_noise) 

            if S(n,m,step) > threshold_work(step)
                Strobe_signal(n,m,step) = 1;
                S_threshold(n,m,step) = S(n,m,step);
            else
                Strobe_signal(n,m,step) = 0;
                S_threshold(n,m,step) = 0;
            end
        end

    end

 
end






    figure(2);
    subplot(2,1,1)
    plot(threshold_adaptive,'+-');

    subplot(2,1,2)
    plot(count_adaptive,'+-');

    figure(3);
    
    subplot(4,1,1)
    plot(S(:),'+-b');
    
    subplot(4,1,2)
    plot(Strobe_noise(:),'+-r');
    
    subplot(4,1,3)
    plot(S_threshold(:) ,'+-g'); 

    subplot(4,1,4)
    plot(Strobe_signal(:) ,'+-k'); 



%% сохранение данных в файл
    %% сохранение входных данных в файл
%dlmwrite('S.txt',S(:), 'newline', 'pc');
%dlmwrite('Strobe_noise.txt',Strobe_noise(:), 'newline', 'pc');

S_line = S(:);
Strobe_line = Strobe_noise(:);

Strobe_signal_line = Strobe_signal(:);
S_threshold_line = S_threshold(:);

save('S.mat','S_line','Strobe_line','Strobe_signal_line','S_threshold_line', 'threshold_adaptive','count_adaptive'  );



