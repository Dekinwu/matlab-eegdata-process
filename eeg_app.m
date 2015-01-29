filename='F:\课题\毕业大论文\第四章电刺激与EEG\CES实验数据\处理matlab程序\zh_3.CNT';

EEG = pop_loadcnt(filename , 'dataformat', 'int16');

%chan_data=EEG.data(10,:);

chans_power=zeros(68,4);  %68个导联，每个导联信号4种节律平均功率

for(i=10:15) %i<69;i++)
   chan_data=EEG.data(i,:); 
 %   chan_fftpower(chan_data);
  %chan_power(1,:)=chan_fftpower(chan_data);
  
chans_power(i,:)= single_chan_fftpower(i,chan_data);


end
  
  
  
   %end