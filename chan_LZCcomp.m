function  [lzc] = chan_LZCcomp(filename,channel,lzc_num)

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

index_down=2000;  %�ӵڶ��뿪ʼ
lzc=zeros(EEG.nbchan,lzc_num);

for i=1:EEG.nbchan
    for j=1:lzc_num
        index_up=index_down+1999;  %ÿ������2s
        index=index_down:index_up;
        lzcdata=EEG.data(i,index);
        lzc(i,j)=EEG_Complexic(lzcdata);
        index_down=index_up+1;
    end
end
        


end

