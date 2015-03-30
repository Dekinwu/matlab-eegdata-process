%���е缫������ʶ��ʵ��ʹ��ʱ������ȥ����Ӧ������
% channel={                'FP1','FPZ','FP2',...
%                            'AF3','AF4',...
%              'F7','F5','F3','F1','FZ','F2','F4','F6','F8',...
%          'FT7','FC5','FC3','FC1','FCZ','FC2','FC4','FC6','FT8',...
%             'T7','C5','C3','C1','CZ','C2','C4','C6','T8',...
%          'TP7','CP5','CP3','CP1','CPZ','CP2','CP4','CP6','TP8',...
%             'P7','P5','P3','P1','PZ','P2','P4','P6','P8',...
%          'PO7', 'PO5','PO3','PO1','POZ','PO2','PO4','PO6','PO8',...
%                            'O1','OZ','O2'...
%           }; 
% 

clear all;
filename_pre='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\ly\sh_ly_0316\sh_ly_h1.cnt';

channel={              
             'CPZ','P3','P1','PZ','POZ','P4'
          }; 

channum=size(channel);
channum=channum(1,2);

%cell���飬���ڱ���Ƶ�ʺ�ͨ���ַ���
channel_info=cell(1,1+channum);
channel_info(1,1)=cellstr('Freq(Hz)');

for i=2:channum+1
    s=channel{1,i-1};
    st=[s];
     channel_info(1,i)=cellstr(st);
end


NFFT=1024;
specdata=zeros(1+channum,NFFT+1); %���ڱ���Ƶ�ʺ͸�ͨ���̼�ǰ������
[spec_pre,freqs]=chan_speccomp(filename_pre,channel);

%����iaf
ms=mean(spec_pre,1);
ms=ms(1,1:64);
[c,i]=max(ms(14:35));   %��7--18hz��Χ����Ѱiaf
iaf_freq=freqs(1,i+13);
specdata(1,:)=freqs;
specdata(2:(channum+1),:)=spec_pre;

%����Ӧ������� iaf��Ӧ����Ƶ�ס�����iaf���õĵ�����Ϣ��iafƵ��
index_dir=findstr(filename_pre,'\');
savepath=[filename_pre(1:index_dir(end)-1)  '\'];
spec_file_name=['iaf_spec' '.mat'];
specdata=specdata';
specdata=specdata(1:64,:);
save([savepath,spec_file_name],'specdata');
save([savepath,['iaf_chan_info','.mat']],'channel_info');
save([savepath,['iaf','.mat']],'iaf_freq');


