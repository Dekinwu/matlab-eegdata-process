%{
input: cnt�Ե�����
output�� all_chan_power2   ����������4�ֲ�ͬ����ƽ������
˵����ͨ������single_chan_fftpower��ȡ���������Ľ���ƽ�����ʣ����ú�all_chan_fftpowerһ����

%}

function  all_chan_power2=all_chan_fftpower2(filename,channel_num)

EEG = pop_loadcnt(filename , 'dataformat', 'int16');

chan_num=channel_num;
%chan_data=EEG.data(10,:);

chans_power=zeros(chan_num,4);  %68��������ÿ�������ź�4�ֽ���ƽ������

for(i=1:chan_num) %i<69;i++)
   chan_data=EEG.data(i,:); 
 %   chan_fftpower(chan_data);
  %chan_power(1,:)=chan_fftpower(chan_data);
chans_power(i,:)= single_chan_fftpower(i,chan_data);
end
 
all_chan_power2=chans_power;

end
  