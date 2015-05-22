% ���иýű������Դ�ʵ�������ļ�����ȡ��ÿ�����Եķ�Ӧʱ���׼ȷ�ʲ���������ӦĿ¼����Ӧ�ļ��£�
%�����ɵ��ļ�����origin�����Խ������ͳ�Ʒ�����
%ʹ�øýű�ʱ������ȷ������ԭʼ��������Ŀ¼�ʹ��������ݱ����Ŀ¼��

% ������תʵ����������Ŀ¼
path='F:\����\CESʵ�����ݼ�����\ʵ������\CES��Ϊѧ\RT_time\sham';
% ��������ݱ���Ŀ¼
savepath='F:\����\CESʵ�����ݼ�����\ʵ������\CES��Ϊѧ\rt_matlab_result\sham\';
Subjects_num=10;   %���Եĸ���
groups_num=8;  %ÿ��������������
times_per_group=96;


 %���б���ÿ��ʵ���׼ȷ�ʺͷ�Ӧʱ���ֵ
correctavg=zeros(Subjects_num,groups_num); 
latencyavg=zeros(Subjects_num,groups_num);

%ÿ������������ʵ���׼ȷ�ʺͷ�Ӧʱ������
correct_per_subj=zeros(groups_num,times_per_group);
latency_per_subj=zeros(groups_num,times_per_group);

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
    correct_per_subj(i,:)=data.subject.Correct;
    latency_per_subj(i,:)=data.subject.Latency;
    end
  
    %��ÿ�����Ե�����ת������ģʽ���棬����origin����
   tcorrect=correct_per_subj'
   tlatency=latency_per_subj';
   correctfilename=['correct_' name '.mat'];
   save([savepath,correctfilename],'tcorrect');
   latencyfilename=['latency_'  name '.mat'];
   save([savepath,latencyfilename],'tlatency');
       
   subj_count=subj_count+1;
   
   %��ÿ������ÿ��ʵ���׼ȷ�ʺͷ�Ӧʱ���ֵ��������
   correctavg(subj_count,:)=mean(tcorrect,1);
   latencyavg(subj_count,:)=mean(tlatency,1);    
  end
%  ����ÿ��correct��latency��ֵ��   
correctavgfilename=['correctavg_of_all_subjs' '.mat'];
save([savepath,correctavgfilename],'correctavg');
latencyavgfilename=['latencyavg_of_all_subjs' '.mat'];
save([savepath,latencyavgfilename],'latencyavg');
