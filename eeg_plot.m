filename='F:\课题\毕业大论文\第四章电刺激与EEG\CES实验数据\处理matlab程序\gwx_3.CNT';


ch1=11;
ch2=12;

EEG = pop_loadcnt(filename , 'dataformat', 'int16');
time=linspace(1,10,10000);
ch1_data=EEG.data(ch1,:);
ch2_data=EEG.data(ch2,:);
time1=linspace(1,10000,10000);
data1=ch1_data(time1);
data2=ch2_data(time1);


subplot(2,1,1);

plot(time,data1,'r');
subplot(2,1,2);
plot(time,data2,'b');

