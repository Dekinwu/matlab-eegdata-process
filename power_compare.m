%{



%}

pre_filename='F:\����\��ҵ������\�����µ�̼���EEG\CESʵ������\����matlab����\zh_1.CNT';
post_filename='F:\����\��ҵ������\�����µ�̼���EEG\CESʵ������\����matlab����\zh_3.CNT';

%{
pre_filename='F:\����\��ҵ������\�����µ�̼���EEG\CESʵ������\����matlab����\gwx_1.1.CNT';
post_filename='F:\����\��ҵ������\�����µ�̼���EEG\CESʵ������\����matlab����\gwx_3.CNT';
%}

chan_num=62;
pre_chan_power=zeros(chan_num,4);  %68��������ÿ�������źŴ̼�ǰ4�ֽ���ƽ������
post_chan_power=zeros(chan_num,4);  %68��������ÿ�������źŴ̼���4�ֽ���ƽ������

pre_chan_power=all_chan_fftpower2(pre_filename,chan_num);
post_chan_power=all_chan_fftpower2(post_filename,chan_num);

plot_chan=linspace(1,62,62);
%�̼�ǰ�������alpha����ƽ������
pre_chan_alpha=pre_chan_power(:,3);
post_chan_alpha=post_chan_power(:,3);
subplot(2,2,1);
plot(plot_chan,pre_chan_alpha(plot_chan),'r-o',plot_chan,post_chan_alpha(plot_chan),'b--h');
xlabel('����');ylabel('alpha ƽ�����ʣ�uV^2/Hz��');
title('�̼�ǰ�������alpha����ƽ������');
legend('�̼�ǰ','�̼���');

%�̼�ǰ�������beta����ƽ������
pre_chan_beta=pre_chan_power(:,4);
post_chan_beta=post_chan_power(:,4);
subplot(2,2,2);
plot(plot_chan,pre_chan_beta(plot_chan),'r-o',plot_chan,post_chan_beta(plot_chan),'b--h');
xlabel('����');ylabel('beta ƽ�����ʣ�uV^2/Hz��');
title('�̼�ǰ�������beta����ƽ������');
legend('�̼�ǰ','�̼���');

%�̼�ǰ����������н���ƽ������֮��
pre_chan_total=sum(pre_chan_power,2);
post_chan_total=sum(post_chan_power,2);
subplot(2,2,3);
plot(plot_chan,pre_chan_total(plot_chan),'r-o',plot_chan,post_chan_total(plot_chan),'b--h');
xlabel('����');ylabel('���н���ƽ�����ʣ�uV^2/Hz��');
title('�̼�ǰ����������н���ƽ������֮��');
legend('�̼�ǰ','�̼���');

%�̼�ǰ������ɹ��ʱ仯
pre_rth_total=sum(pre_chan_power);
post_rth_total=sum(post_chan_power);
subplot(2,2,4);
plot(linspace(1,4,4),pre_rth_total,'r-o',linspace(1,4,4),post_rth_total,'b--h');
xlabel('����');ylabel('����ƽ�����ʣ�uV^2/Hz��');
set(gca,'XTick',1:4);
set(gca,'XTickLabel',{'\delta','\Theta','\alpha','\beta'});
title('�̼�ǰ������ɹ���');
legend('�̼�ǰ','�̼���');





