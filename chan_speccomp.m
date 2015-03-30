% chan_speccomp---该函数根据传递的cnt文件名和通道名计算各个通道的功率谱，函数内部会对脑电数据进行滤波
%input: 
%    filename:CNT文件名
%    channel：需要计算功率谱的通道
%       channel=0：计算所有通道
%       channel不等于0,计算给定通道
% output:
%       spec:功率谱，单位dB
%       freqs:频率，范围0--32Hz,间距500/1025Hz

% Usage example:[spec,freqs]=chan_speccomp(filename="zx_closeac.cnt",{'P1','P2'})
%               [spec,freqs]=chan_speccomp(filename="zx_closeac.cnt",0)
% 

function [spec,freqs]=chan_speccomp(filename,channel)

if filename((end-3):end)=='.set'
 EEG=pop_loadset(filename);
end

if filename((end-3):end)=='.cnt'
 EEG=pop_loadcnt(filename,'dataformat','int32','scale','on');
end

if isequal(channel,0)
{
 }
else
%选择电极
    EEG = pop_select( EEG,'channel',channel);
%}
end

fs=1000;

%滤波，只针对cnt文件滤波
if filename((end-3):end)=='.cnt'
data1=eegfilt(EEG.data,fs,1,0,0,5*fs);
data2=eegfilt(data1,fs,0,40,0,fs);
EEG.data=data2;
end

%求功率谱，采用pwlech求功率谱方法，不需要叠加平均，该方法本身已经叠加平均求功率
[spec]=pop_spectopo(EEG, 1, [0  (EEG.pnts-100)], 'EEG' , 'percent', 15, 'freqrange',[1 30],'electrodes','off');

%在pwelch方法中采用的NFFT长度为2048
 NFFT=2048; 
 %频率的分辨率为500/1025
 freqs=fs/2*linspace(0,1,NFFT/2+1);
