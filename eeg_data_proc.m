%所有电极导联标识，实际使用时，可以去掉相应坏导联
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
filename_pre='F:\课题\CES实验数据及处理\实验数据\CES脑电\eeglab预处理后数据\sham_ly\sh_ly_pre.set';
filename_post='F:\课题\CES实验数据及处理\实验数据\CES脑电\eeglab预处理后数据\sham_ly\sh_ly_post.set';
channel={                'FP1','FPZ','FP2',...
                           'AF3','AF4',...
             'F7','F5','F1','FZ','F2','F4','F6','F8',...
         'FT7','FC3','FC1','FCZ','FC2','FC4','FC6','FT8',...
            'C5','C3','C1','CZ','C2','C4','C6',...
         'TP7','CP5','CP3','CPZ','CP2','CP4','CP6','TP8',...
            'P7','P5','P3','P1','PZ','P4','P6','P8',...
         'PO7', 'PO5','PO3','POZ','PO4','PO6','PO8',...
                           'O1',...
          }; 


channum=size(channel);
channum=channum(1,2);

%cell数组，用于保存频率和通道字符串
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
specdata=zeros(1+2*channum,NFFT+1); %用于保存频率和各通道刺激前后功率谱

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




