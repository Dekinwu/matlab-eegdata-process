%{
input��
   channeldata:ĳһ��������eeg���ݣ�������ͨ��loadcnt��ȡ
output:
   �õ���4�ֽ��ɲ�ƽ������

˵����
  �����ȶԵ������ݽ��д�ͨ�˲��󣬽�ȡ��10s����10+4.096*20=92s���ݣ���4.096s
ΪһС�Σ�ȡ20�κ����ƽ���󣬶������fft�任��
  fft�任�Ĳ���Ƶ��Ϊ64Hz����������Ϊ256��

�������ƽ������ʱ����fft�任�õ��ģ�f��YZ�����߽��л����ٳ���Ƶ����ȡ�

%}


function  single_chan_power=single_chan_fftpower(channel,channeldata)


%filename='F:\����\��ҵ������\�����µ�̼���EEG\CESʵ������\����matlab����\zh_3.CNT';

%EEG = pop_loadcnt(filename , 'dataformat', 'int16');


%channeldata=EEG.data(channel,:);
fs=1000;
%��ͨ�˲�,1--40HZ
data1=eegfilt(channeldata,fs,1,0,0,5*fs);   
smoothdata=eegfilt(data1,fs,0,40,0,fs);


%����̼�ʱ���ɼ��̼�ǰ���100s���ݡ�
%����ƽ�����ӵ�10s���ݿ�ʼ��ÿ4.096sһ�Σ�����ȡ20�����ݣ�
section_num=20;
section_datanum=4096;

A0=linspace(1,section_datanum,section_datanum)+10000;  %4s������
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

%select���ǵ���ƽ�����ͨ������
if rem(channel,2)
    k=100;
else
    k=1000000;
end
select=k*( smoothdata(A0)+smoothdata(A1)+smoothdata(A2)+smoothdata(A3) + smoothdata(A4)...
     +smoothdata(A5)+smoothdata(A6)+smoothdata(A7)+smoothdata(A8)+smoothdata(A9)...
     +smoothdata(A10)+smoothdata(A11)+smoothdata(A12)+smoothdata(A13)+smoothdata(A14)...
     +smoothdata(A15)+smoothdata(A16)+smoothdata(A17)+smoothdata(A18)+smoothdata(A19))/section_num;

 
 
 %{
 time=linspace(0,section_datanum/1000,section_datanum);

 subplot(2,1,1);
 plot(time,select);
xlabel('ʱ�䣨s��');
ylabel('uV');
title('����ƽ������');
     %}
   
%����FFT�����׼���
Fs = 64;                    % Sampling frequency���Ե�Ƶ��һ�㲻����32Hz
N=256;                      %��������
%T = 1/Fs;                     % Sample time
L = 256;                     % Length of signal
%t = (0:L-1)*T;                % Time vector
s_fft=16*linspace(1,256,256);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
power=[0,0,0,0];
 
   fftdata = select(s_fft);

    Y = fft(fftdata,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    
    YP=2*abs(Y(1:NFFT/2+1));
   
    
    %delta(1--4Hz)
    power(1,1)=sum(YP(linspace(4,15,12)))/12;
    %theta (4�C8 Hz)
    power(1,2)=sum(YP(linspace(16,31,16)))/16;
    %alpha(8�C13 Hz),
    power(1,3)=sum(YP(linspace(32,51,20)))/20;
    %beta (13�C30 Hz)
    power(1,4)=sum(YP(linspace(52,119,68)))/68;
    single_chan_power=power;

%{
% Plot single-sided amplitude spectrum.
subplot(2,1,2);
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

    %}

%��������ɵ�ƽ�������ף�uV2/Hz)






end





