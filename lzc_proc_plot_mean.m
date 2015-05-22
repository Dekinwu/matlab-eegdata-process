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
filename_pre='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\Ԥ������\cjy\stim_cjy\stim_cjy_pre.set';
filename_post='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\Ԥ������\cjy\stim_cjy\stim_cjy_pOST.set';
channel={               
           'C2','CPZ','CP2','PZ','POZ',
          }; 


channum=size(channel);
channum=channum(1,2);

%cell���飬���ڱ���ͨ���ַ���
channel_info=cell(1,2*channum);
%channel_info(1,1)=cellstr('Freq(Hz)');

for i=1:channum
    s=channel{1,i};
    st=[s '_' 'pre'];
     channel_info(1,i)=cellstr(st);
end

for i=channum+1:2*channum
    s=channel{1,i-channum};
    st=[s '_' 'post'];
    channel_info(1,i)=cellstr(st);
end

LZC_NUM=16; %ÿ��ͨ������60��lzc���ݣ�ÿ2sһ�����ݼ���lzc

lzc=zeros(2*channum,LZC_NUM); %���ڱ���̼�ǰ��Lempel-Ziv ���Ӷ�

lzc_pre=chan_LZCcomp(filename_pre,channel,LZC_NUM);

lzc(1:channum,:)=lzc_pre;

lzc_post=chan_LZCcomp(filename_post,channel,LZC_NUM);
lzc( (1+channum):(2*channum),: )=lzc_post;

%����ÿ��ͨ���̼�ǰ���lzc���ݡ�
index_dir=findstr(filename_pre,'\');
savepath=[filename_pre(1:index_dir(end)-1)  '\'];
lzc_file_name=['lzc' '.mat'];
lzcdata=lzc';
% specdata=specdata(1:64,:);
save([savepath,lzc_file_name],'lzcdata');
save([savepath,['chan_info','.mat']],'channel_info');

%��ȡ����ͨ����lzcƽ��ֵ�������ǰһ����preǰ����һ����post
lzc_mean=mean(lzcdata,1);

%�������ͨ����ƽ��lzcֵ
savepath=[filename_pre(1:index_dir(end)-1)  '\'];
lzcmean_file_name=['lzc_mean' '.mat'];
save([savepath,lzcmean_file_name],'lzc_mean');


% %�����̼�ǰ��ƽ��lzc
% figure;
% p=plot(freqs(:,1:64),pre_spec_mean,'-r',freqs(:,1:64),post_spec_mean,'-b');
% set(p,'LineWidth',2)
% legend('�̼�ǰ','�̼���');
% xlabel('Frequency (Hz)');
% ylabel('10*log_{10}(\muV^{2}/Hz)');



