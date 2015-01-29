%{
input: cnt脑电数据
output： all_chan_power2   各个导联的4种不同节律平均功率
说明：通过调用single_chan_fftpower获取各个导联的节律平均功率，作用和all_chan_fftpower一样。

%}

function  all_chan_power2=all_chan_fftpower2(filename,channel_num)

EEG = pop_loadcnt(filename , 'dataformat', 'int16');

chan_num=channel_num;
%chan_data=EEG.data(10,:);

chans_power=zeros(chan_num,4);  %68个导联，每个导联信号4种节律平均功率

for(i=1:chan_num) %i<69;i++)
   chan_data=EEG.data(i,:); 
 %   chan_fftpower(chan_data);
  %chan_power(1,:)=chan_fftpower(chan_data);
chans_power(i,:)= single_chan_fftpower(i,chan_data);
end
 
all_chan_power2=chans_power;

end
  