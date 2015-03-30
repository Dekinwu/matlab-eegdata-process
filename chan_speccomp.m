% chan_speccomp---�ú������ݴ��ݵ�cnt�ļ�����ͨ�����������ͨ���Ĺ����ף������ڲ�����Ե����ݽ����˲�
%input: 
%    filename:CNT�ļ���
%    channel����Ҫ���㹦���׵�ͨ��
%       channel=0����������ͨ��
%       channel������0,�������ͨ��
% output:
%       spec:�����ף���λdB
%       freqs:Ƶ�ʣ���Χ0--32Hz,���500/1025Hz

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
%ѡ��缫
    EEG = pop_select( EEG,'channel',channel);
%}
end

fs=1000;

%�˲���ֻ���cnt�ļ��˲�
if filename((end-3):end)=='.cnt'
data1=eegfilt(EEG.data,fs,1,0,0,5*fs);
data2=eegfilt(data1,fs,0,40,0,fs);
EEG.data=data2;
end

%�����ף�����pwlech�����׷���������Ҫ����ƽ�����÷��������Ѿ�����ƽ������
[spec]=pop_spectopo(EEG, 1, [0  (EEG.pnts-100)], 'EEG' , 'percent', 15, 'freqrange',[1 30],'electrodes','off');

%��pwelch�����в��õ�NFFT����Ϊ2048
 NFFT=2048; 
 %Ƶ�ʵķֱ���Ϊ500/1025
 freqs=fs/2*linspace(0,1,NFFT/2+1);
