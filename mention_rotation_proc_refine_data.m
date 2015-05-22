% ���иýű������Դ�ʵ�������ļ�����ȡ��ÿ�����Եķ�Ӧʱ���׼ȷ�ʲ���������ӦĿ¼����Ӧ�ļ��£�
%�����ɵ��ļ�����origin�����Խ������ͳ�Ʒ�����
%ʹ�øýű�ʱ������ȷ������ԭʼ��������Ŀ¼�ʹ��������ݱ����Ŀ¼��

% ������תʵ����������Ŀ¼
path='F:\����\CESʵ�����ݼ�����\ʵ������\CES��Ϊѧ\RT_time\theta';
% ��������ݱ���Ŀ¼
savepath='F:\����\CESʵ�����ݼ�����\ʵ������\CES��Ϊѧ\rt_matlab_result\theta\';
Subjects_num=10;   %���Եĸ���
groups_num=8;  %ÿ��������������
times_per_group=96;


 %���б���ʵ��ǰ���ƽ��׼ȷ�ʺ�ƽ����Ӧʱ��
correctavg=zeros(Subjects_num,2); 
latencyavg=zeros(Subjects_num,2);

%ÿ������������ʵ���׼ȷ�ʺͷ�Ӧʱ������
correct_per_subj=zeros(1,groups_num*times_per_group);
latency_per_subj=zeros(1,groups_num*times_per_group);

% Files = dir(fullfile( path,'*.*'));
Files = dir(fullfile( path));
LengthFiles = length(Files);

subj_count=0;

for iCount = 1:LengthFiles    % �ж��Ƿ����ļ���    
    name = Files(iCount).name;    
    if name=='.'        
       continue;    
    end
    s = [path  '\' name '\'];        %�����ļ�   
    Folders = dir(fullfile( s,'*.*'));    
    Length= length(Folders);  
    
    i=0; 
    for iCount = 1:Length;          
        if strcmp(Folders(iCount).name, '.') | ...
           strcmp(Folders(iCount).name, '..')
           continue;
        end
    i=i+1; 
    filestruct=Folders(iCount);
    filepath=[s filestruct.name];
    data=load(filepath);
    s_down=(i-1)*times_per_group+1;
    s_up=i*times_per_group;
    correct_per_subj(1,s_down:s_up)=data.subject.Correct;
    latency_per_subj(1,s_down:s_up)=data.subject.Latency;
    end 
   
   %�޳�����Ӧ�µķ�Ӧʱ������
   for iCount=1:groups_num*times_per_group
           if(correct_per_subj(1,iCount) == -1 )
               latency_per_subj(1,iCount)=0;
           end
   end
   %�޳��̼�ǰ��Ӧʱ��С��200ms�ĵ�
   pre_latency=latency_per_subj(1:groups_num*times_per_group/2);
   post_latency=latency_per_subj((1+groups_num*times_per_group/2):(groups_num*times_per_group));
   pre_more200=find(pre_latency>0.2);
   post_more200=find(post_latency>0.2);
   
   pre_latency_r1=pre_latency(pre_more200);
   post_latency_r1=post_latency(post_more200); %�õ�����200ms������
   
    %�޳�����ƽ����Ӧʱ������׼�������
   pre_meanla=mean(pre_latency_r1);
   pre_varla=std(pre_latency_r1,0,2);
   post_meanla=mean(post_latency_r1);
   post_varla=std(post_latency_r1,0,2);
   
   less3var_pre=find( pre_latency_r1 < (pre_meanla+3*pre_varla) );
   less3var_post=find( post_latency_r1 < (post_meanla+3*post_varla) );
   
   pre_latency_final=pre_latency_r1(less3var_pre);
   post_latency_final=post_latency_r1(less3var_post);  %�õ�������ȡ������
   
   
   subj_count=subj_count+1;
   
   %��ÿ������ʵ��ǰ���׼ȷ�ʺͷ�Ӧʱ���ֵ��������
   % pre_correct=correct_per_subj(1:groups_num*times_per_group/2);
   correctavg(subj_count,1)=mean( correct_per_subj(1:groups_num*times_per_group/2) );
   correctavg(subj_count,2)=mean( correct_per_subj((1+groups_num*times_per_group/2):(groups_num*times_per_group)));
   latencyavg(subj_count,1)=mean(pre_latency_final); 
   latencyavg(subj_count,2)=mean(post_latency_final);
end
  

%  �������б���ʵ��ǰ���ƽ��׼ȷ�ʺ�ƽ����Ӧʱ�䡣   
correctavgfilename=['correctavg_of_all_subjs' '.mat'];
save([savepath,correctavgfilename],'correctavg');
latencyavgfilename=['latencyavg_of_all_subjs' '.mat'];
save([savepath,latencyavgfilename],'latencyavg');


%�����б���ʵ��ǰ���ƽ����Ӧʱ�������ʱ���  �������ʶ���ΪPost-pre/pre
ratelatency=( latencyavg(:,2)-latencyavg(:,1) ) ./latencyavg(:,1) *100;

%���������˵�������
rateavgfilename=['rateavg_of_all_subjs' '.mat'];
save([savepath,rateavgfilename],'ratelatency');

ratelat_meanla=mean(ratelatency);
ratelat_varla=std(ratelatency,0,1);

ratelatrefine1=find( (ratelat_meanla-3*ratelat_varla)<ratelatency );

ratelatfinal1=ratelatency(ratelatrefine1);
latencyavgrefine1=latencyavg(ratelatrefine1,:);

ratelatrefine2=find( ratelatfinal1 < (ratelat_meanla+3*ratelat_varla) );

ratefinal=ratelatfinal1(ratelatrefine2);  %���յõ���������������׼��֮�ڵ�����
latencyavgfinal=latencyavg(ratelatrefine2,:); %��Ӧ��ǰ��Ӧʱ�䡣

%���澭������ˢѡ���ƽ�������ʺ�ǰ��Ӧʱ��
latavgfinalfilename=['latavgfinal_of_all_subjs' '.mat'];
save([savepath,latavgfinalfilename],'latencyavgfinal');
ratefinalfilename=['ratefinal_of_all_subjs' '.mat'];
save([savepath,ratefinalfilename],'ratefinal');







