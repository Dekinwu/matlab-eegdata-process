clear all;
filename_pre='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\eeglabԤ����������\sham_ly\sh_ly_pre.set';
filename_post='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\eeglabԤ����������\sham_ly\sh_ly_post.set';
channel={'F1','FZ','F2','FC1','FCZ','FC2','C1','C2','CP2','CPZ'};



channum=size(channel);
channum=channum(1,2);

%cell���飬���ڱ���Ƶ�ʺ�ͨ���ַ���
channel_info=cell(1,1+2*channum);
channel_info(1,1)=cellstr('Freq(Hz)');

for i=2:channum+1
    s=channel{1,i-1};
%     s={s};
    st=[s '_' 'pre'];
     channel_info(1,i)=cellstr(st);
%    channel_info(1,i)=st;
end

for i=channum+2:2*channum+1
    s=channel{1,i-channum-1};
%     s={s};
    st=[s '_' 'post'];
    channel_info(1,i)=cellstr(st);
%     channel_info(1,i)=st;
end


NFFT=1024;
specdata=zeros(1+2*channum,NFFT+1); %���ڱ���Ƶ�ʺ͸�ͨ���̼�ǰ������

% [spec_pre,freqs]=chan_speccomp_forset(filename_pre,{'F1','FZ','F2','FC1','FCZ','FC2','C1','CZ','C2','CP1','CPZ','CP2','P1','PZ','P2'});
[spec_pre,freqs]=chan_speccomp_forset(filename_pre,channel);

specdata(1,:)=freqs;
specdata(2:(channum+1),:)=spec_pre;

% filename_post='F:\����\CESʵ�����ݼ�����\ʵ������\CES�Ե�\eeglabԤ����������\stim_zhx\stim_zhx_post.set';

% [spec_post,freqs]=chan_speccomp_forset(filename_post,{'F1','FZ','F2','FC1','FCZ','FC2','C1','CZ','C2','CP1','CPZ','CP2','P1','PZ','P2'});
[spec_post,freqs]=chan_speccomp_forset(filename_post,channel);

specdata((channum+2):(1+2*channum),:)=spec_post;

index_dir=findstr(filename_pre,'\');

savepath=[filename_pre(1:index_dir(end)-1)  '\'];
spec_file_name=['spec' '.mat'];
specdata=specdata';
specdata=specdata(1:64,:);
save([savepath,spec_file_name],'specdata');


% figure;
% for i=1:channum
% plot(freqs(1:64),spec_pre(i,1:64));%'r','LineWidth',2);
% hold on;
% end
% legend('PRE_F1','PRE_FZ','PRE_F2','PRE_FC1','PRE_FCZ','PRE_FC2','PRE_C1','PRE_CZ','PRE_C2','PRE_CP1','PRE_CPZ','PRE_CP2','PRE_P1','PRE_PZ','PRE_P2');
% hold on;
% for i=1:channum
% plot(freqs(1:64),spec_post(i,1:64));%,'g','LineWidth',2);
% hold on;
% end
% legend('POST_F1','POST_FZ','POST_F2','POST_FC1','POST_FCZ','POST_FC2','POST_C1','POST_CZ','POST_C2','POST_CP1','POST_CPZ','POST_CP2','POST_P1','POST_PZ','POST_P2');