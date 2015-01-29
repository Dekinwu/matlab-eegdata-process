%{
input：
   channeldata:某一个导联的eeg数据，该数据通过loadcnt读取
output:
   该导联4种节律波平均功率

说明：
  函数先对导联数据进行带通滤波后，截取第10s至第10+4.096*20=92s数据，以4.096s
为一小段，取20段后叠加平均后，对其进行fft变换。
  fft变换的采样频率为64Hz，采样点数为256，

计算节律平均功率时，将fft变换得到的（f，YZ）曲线进行积分再除以频带宽度。

%}


function  all_chan_power=all_chan_fftpower(filename,channel_num)


%filename='F:\课题\毕业大论文\第四章电刺激与EEG\CES实验数据\处理matlab程序\zh_3.CNT';

EEG = pop_loadcnt(filename , 'dataformat', 'int16');

chan_num=channel_num;

chan_power=zeros(chan_num,4);  %68个导联，每个导联信号4种节律平均功率


fs=1000;
%带通滤波,1--40HZ
data1=eegfilt(EEG.data,fs,1,0,0,5*fs);   
filtereddata=eegfilt(data1,fs,0,40,0,fs);


%假设刺激时，采集刺激前后的100s数据。
%叠加平均，从第10s数据开始，每4.096s一段，共截取20段数据，
section_num=20;
section_datanum=4096;

A0=linspace(1,section_datanum,section_datanum)+10000;  %4s的数据
A1=A0+section_datanum; 
A2=A1+section_datanum;
A3=A2+section_datanum;
A4=A3+section_datanum;
A5=A4+section_datanum;
A6=A5+section_datanum;
A7=A6+section_datanum;
A8=A7+section_datanum;
A9=A8+section_datanum;
A10=A9+section_datanum;
A11=A10+section_datanum;
A12=A11+section_datanum;
A13=A12+section_datanum;
A14=A13+section_datanum;
A15=A14+section_datanum;
A16=A15+section_datanum;
A17=A16+section_datanum;
A18=A17+section_datanum;
A19=A18+section_datanum;



%select即是叠加平均后的通道波形
for(i=1:chan_num)
smoothdata=filtereddata(i,:);

%select即是叠加平均后的通道波形
if rem(i,2)   %判断导联号，根据导联号决定系数，具体原因不明
    k=100;
else
    k=1000000;
end
select(i,:)=k*( smoothdata(A0)+smoothdata(A1)+smoothdata(A2)+smoothdata(A3) + smoothdata(A4)...
     +smoothdata(A5)+smoothdata(A6)+smoothdata(A7)+smoothdata(A8)+smoothdata(A9)...
     +smoothdata(A10)+smoothdata(A11)+smoothdata(A12)+smoothdata(A13)+smoothdata(A14)...
     +smoothdata(A15)+smoothdata(A16)+smoothdata(A17)+smoothdata(A18)+smoothdata(A19))/section_num;

end
   
%进行FFT功率谱计算
Fs = 64;                    % Sampling frequency，脑电频率一般不高于32Hz
N=256;                      %采样点数
%T = 1/Fs;                     % Sample time
L = 256;                     % Length of signal
%t = (0:L-1)*T;                % Time vector
s_fft=16*linspace(1,256,256);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
power=[0,0,0,0];
 
for(i=1:chan_num)
    fftsignal=select(i,:);
    fftdata = fftsignal(s_fft);

    Y = fft(fftdata,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    
    YP=2*abs(Y(1:NFFT/2+1));
   
    
    %delta(1--4Hz)
    power(1,1)=sum(YP(linspace(4,15,12)))/12;
    %theta (4–8 Hz)
    power(1,2)=sum(YP(linspace(16,31,16)))/16;
    %alpha(8–13 Hz),
    power(1,3)=sum(YP(linspace(32,51,20)))/20;
    %beta (13–30 Hz)
    power(1,4)=sum(YP(linspace(52,119,68)))/68;
    chan_power(i,:)=power;

end
%{
% Plot single-sided amplitude spectrum.
subplot(2,1,2);
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
%}

%计算各节律的平均功率谱（uV2/Hz)


all_chan_power =chan_power;



end





