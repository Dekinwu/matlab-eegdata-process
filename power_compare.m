%{



%}

pre_filename='F:\课题\毕业大论文\第四章电刺激与EEG\CES实验数据\处理matlab程序\zh_1.CNT';
post_filename='F:\课题\毕业大论文\第四章电刺激与EEG\CES实验数据\处理matlab程序\zh_3.CNT';

%{
pre_filename='F:\课题\毕业大论文\第四章电刺激与EEG\CES实验数据\处理matlab程序\gwx_1.1.CNT';
post_filename='F:\课题\毕业大论文\第四章电刺激与EEG\CES实验数据\处理matlab程序\gwx_3.CNT';
%}

chan_num=62;
pre_chan_power=zeros(chan_num,4);  %68个导联，每个导联信号刺激前4种节律平均功率
post_chan_power=zeros(chan_num,4);  %68个导联，每个导联信号刺激后4种节律平均功率

pre_chan_power=all_chan_fftpower2(pre_filename,chan_num);
post_chan_power=all_chan_fftpower2(post_filename,chan_num);

plot_chan=linspace(1,62,62);
%刺激前后各导联alpha节律平均功率
pre_chan_alpha=pre_chan_power(:,3);
post_chan_alpha=post_chan_power(:,3);
subplot(2,2,1);
plot(plot_chan,pre_chan_alpha(plot_chan),'r-o',plot_chan,post_chan_alpha(plot_chan),'b--h');
xlabel('导联');ylabel('alpha 平均功率（uV^2/Hz）');
title('刺激前后各导联alpha节律平均功率');
legend('刺激前','刺激后');

%刺激前后各导联beta节律平均功率
pre_chan_beta=pre_chan_power(:,4);
post_chan_beta=post_chan_power(:,4);
subplot(2,2,2);
plot(plot_chan,pre_chan_beta(plot_chan),'r-o',plot_chan,post_chan_beta(plot_chan),'b--h');
xlabel('导联');ylabel('beta 平均功率（uV^2/Hz）');
title('刺激前后各导联beta节律平均功率');
legend('刺激前','刺激后');

%刺激前后各导联所有节律平均功率之和
pre_chan_total=sum(pre_chan_power,2);
post_chan_total=sum(post_chan_power,2);
subplot(2,2,3);
plot(plot_chan,pre_chan_total(plot_chan),'r-o',plot_chan,post_chan_total(plot_chan),'b--h');
xlabel('导联');ylabel('所有节律平均功率（uV^2/Hz）');
title('刺激前后各导联所有节律平均功率之和');
legend('刺激前','刺激后');

%刺激前后各节律功率变化
pre_rth_total=sum(pre_chan_power);
post_rth_total=sum(post_chan_power);
subplot(2,2,4);
plot(linspace(1,4,4),pre_rth_total,'r-o',linspace(1,4,4),post_rth_total,'b--h');
xlabel('节律');ylabel('节律平均功率（uV^2/Hz）');
set(gca,'XTick',1:4);
set(gca,'XTickLabel',{'\delta','\Theta','\alpha','\beta'});
title('刺激前后各节律功率');
legend('刺激前','刺激后');





