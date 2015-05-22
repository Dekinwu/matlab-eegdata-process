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
filename_pre='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\Ԥ������\yjj\stim_yjj\stim_yjj_pre.set';
filename_post='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\Ԥ������\yjj\stim_yjj\stim_yjj_post.set';
channel={               
           'FCZ','C1','C2','CPZ','CP2','PZ','POZ',
          }; 


channum=size(channel);
channum=channum(1,2);

%cell���飬���ڱ���Ƶ�ʺ�ͨ���ַ���
channel_info=cell(1,1+2*channum);
channel_info(1,1)=cellstr('Freq(Hz)');

for i=2:channum+1
    s=channel{1,i-1};
    st=[s '_' 'pre'];
     channel_info(1,i)=cellstr(st);
end

for i=channum+2:2*channum+1
    s=channel{1,i-channum-1};
    st=[s '_' 'post'];
    channel_info(1,i)=cellstr(st);
end



NFFT=1024;
specdata=zeros(1+2*channum,NFFT+1); %���ڱ���Ƶ�ʺ͸�ͨ���̼�ǰ������

[spec_pre,freqs]=chan_speccomp(filename_pre,channel);
specdata(1,:)=freqs;
specdata(2:(channum+1),:)=spec_pre;


[spec_post,freqs]=chan_speccomp(filename_post,channel);
specdata((channum+2):(1+2*channum),:)=spec_post;

index_dir=findstr(filename_pre,'\');
savepath=[filename_pre(1:index_dir(end)-1)  '\'];
spec_file_name=['spec' '.mat'];
specdata=specdata';
specdata=specdata(1:64,:);
save([savepath,spec_file_name],'specdata');
save([savepath,['chan_info','.mat']],'channel_info');

figure;
%��ȡpre_specƽ��ֵ��post_specƽ��ֵ
pre_spec_mean=mean(spec_pre,1);
pre_spec_mean=pre_spec_mean(:,1:64);
post_spec_mean=mean(spec_post,1);
post_spec_mean=post_spec_mean(:,1:64);

%�������ͨ��ƽ��������
spec_mean=zeros(3,64);
spec_mean(1,:)=freqs(:,1:64);
spec_mean(2,:)=pre_spec_mean;
spec_mean(3,:)=post_spec_mean;
spec_mean=spec_mean';
savepath=[filename_pre(1:index_dir(end)-1)  '\'];
spec_file_name=['spec_mean' '.mat'];
save([savepath,spec_file_name],'spec_mean');


%�����̼�ǰ��ƽ��������
p=plot(freqs(:,1:64),pre_spec_mean,'-r',freqs(:,1:64),post_spec_mean,'-b');
set(p,'LineWidth',2)
legend('�̼�ǰ','�̼���');
xlabel('Frequency (Hz)');
ylabel('10*log_{10}(\muV^{2}/Hz)');



