filename='F:\����\��ҵ������\�����µ�̼���EEG\CESʵ������\����matlab����\zh_3.CNT';

EEG = pop_loadcnt(filename , 'dataformat', 'int16');

%chan_data=EEG.data(10,:);

chans_power=zeros(68,4);  %68��������ÿ�������ź�4�ֽ���ƽ������

for(i=10:15) %i<69;i++)
   chan_data=EEG.data(i,:); 
 %   chan_fftpower(chan_data);
  %chan_power(1,:)=chan_fftpower(chan_data);
  
chans_power(i,:)= single_chan_fftpower(i,chan_data);


end
  
  
  
   %end