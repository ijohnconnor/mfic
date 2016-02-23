%% --------------------------------------------- Модуль формирования ИЦ --------------------------------------------------- %

function target  =  define_target_impulse_dopler(azimuth_target, num_surv, detection_impulse, flag_draw)

Nimp            =  16;
period          =  819.2e-6;
df              =  1/period/Nimp;                                                     % шаг между частотными каналами Доплера
max_range       =  8192;                                                                   % максимальная дискрета дальности
 
[Lrange, ~]  =  size(detection_impulse);                              

% Выходная структура импульсов цели
target          =  struct('amplitude', [], 'doppler', [], 'range', [], 'azimuth', [], 'index_range', [], 'num_surv', []);
 

%% ----------------------------------------------------- МАИ -------------------------------------------------------------- %
Fs2             =  10e6;
dt              =  1/Fs2;
bit_azimuth     =  14;
Va              =  360/4;
Va              =  Va * pi/180;
da              =  4 / 2^bit_azimuth;                                                              % интервал между двумя МАИ
width_DA        =  2.5;
width_DA        =  width_DA * pi /180;
azimuth_target  =  ceil( ( (azimuth_target - 0.5 * width_DA) / Va) / da );


%% --------------------------------------- Сканирование импульсов обнаружения --------------------------------------------- %
for i = 1:Lrange
    
impulse    =  detection_impulse(i, :); 

if sum(impulse) ~= 0
    
disp('Импульс обнаружен');

threshold  =  0.8*max(impulse);

% pos_max    =  find(impulse > threshold);
% local_max  =  impulse(pos_max);
local_max  =  [];
pos_max    =  [];

for j = 1:Nimp
    
    if (impulse(ind(j-1, Nimp)) < impulse(j) && impulse(j) > impulse(ind(j+1, Nimp))) && impulse(ind(j, Nimp)) > threshold
       local_max  =  [local_max, impulse(j)];
       pos_max    =  [pos_max, j];
    end;       

end;


%%--------------------------------------------- Оценка частоты Доплера ---------------------------------------------------- %
N_max                  =  length(local_max);
estimation_doppler     =  zeros(1, N_max);

for k = 1:N_max

switch pos_max(k)
    case 1
    index_target       =  [Nimp, pos_max(k), pos_max(k)+1];   
    channel            =  df*[-1 0 1];
    case Nimp 
    index_target       =  [Nimp-1, pos_max(k), 1];
    channel            =  df*[14 15 16];
    otherwise
    index_target       =  [pos_max(k)-1, pos_max(k), pos_max(k)+1];  
    channel            =  df*(index_target-1);
end;
    
estimation_doppler(k)  =  sum(impulse(index_target).*channel) / sum(impulse(index_target));

end;


%% ------------------------------------------------ Формирование ИЦ ------------------------------------------------------- %
target.amplitude     =  [target.amplitude    round(local_max)                                                ];
target.doppler       =  [target.doppler      round(estimation_doppler)                                       ];
target.range         =  [target.range        mod(i, max_range)*ones(1, N_max)                                ];
target.index_range   =  [target.index_range  i*ones(1, N_max)                                                ];
target.azimuth       =  [target.azimuth      ceil(dt*((8*ceil(i/8192) - 1)*8192 + mod(i, 8192)) / da) * ones(1, N_max) ];
% target.azimuth       =  [target.azimuth      round(dt*((8*ceil(i/8192) - 1)*8192 + mod(i, 8192)) / da) * ones(1, N_max) ];


end;

disp(['... ', num2str(100*i/Lrange), ' % ...']);

end;

% Корректировка по МАИ
target.azimuth    =  target.azimuth  +  azimuth_target ;
target.num_surv   =  num_surv * ones(1, length(target.amplitude));


disp('----------------------------------------------- ИЦ определены ------------------------------------------------------');


%% ------------------------------------------------------- Вывод ---------------------------------------------------------- %
if strcmp(flag_draw, 'draw')
       
    amplitude    =  target.amplitude;
    doppler      =  target.doppler; 
    index_range  =  target.index_range;
        
    fig = figure;
    scrsz = get(0, 'ScreenSize');
    set(fig, 'Position', [0.3*scrsz(3) 200 scrsz(3)/2.5 0.5*scrsz(4)]);
    datacursormode on;
    
%     index_range_1  =  repmat((1:Lrange)', 1, num_doppler);
%     doppler_1      =  df*repmat((1:Nimp), Lrange, 1);
%     doppler_1      =  repmat((1:Nimp), Lrange, 1);
%     
%     subplot(2,1,1);
%     stem3(index_range_1, doppler_1, detection_impulse, '-ob', 'markersize', 3, 'markerfacecolor', 'b');
%     xlabel('{\itn}, discret');
%     ylabel('{\itf_{doppler}}, Гц');  
%     zlabel('{\its}({\itt}), lsb');  
%     legend('input');
%     
%     subplot(2,1,2);
%     stem3(index_range, doppler, amplitude, '-or', 'markersize', 3, 'markerfacecolor', 'r');
%     xlabel('{\itn}, discret');
%     ylabel('{\itf_{doppler}}, Гц');  
%     zlabel('{\its}({\itt}), lsb');  
%     legend('output');
   
    subplot(2,1,1);
    stem(index_range, amplitude, '-o', 'MarkerSize', 3, 'MarkerFaceColor', 'k');    
    grid on;   
    xlabel('временные дискреты');
    ylabel('{\its}({\itt}), lsb');  
    title('Испульсы цели');
    
    subplot(2,1,2);
    stem(index_range, doppler, 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'k');    
    grid on; hold on;    
    xlabel('временные дискреты');
    ylabel('\Delta{\itf_{d}}({\itt}), Hz');         
    title('Частотная отстройка Доплера"');       
    set(gca, 'YTick', 0:76:1220);    
    
end;

end
