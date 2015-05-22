% 运行该脚本，可以从实验数据文件中提取出每个被试的反应时间和准确率并保存在相应目录的相应文件下，
%将生成的文件导入origin，可以进行相关统计分析。
%使用该脚本时，请正确的输入原始数据所在目录和处理后的数据保存的目录。

% 心理旋转实验数据所在目录
path='F:\课题\CES实验数据及处理\实验数据\CES行为学\RT_time\sham';
% 处理后数据保存目录
savepath='F:\课题\CES实验数据及处理\实验数据\CES行为学\rt_matlab_result\sham\';
Subjects_num=10;   %被试的个数
groups_num=8;  %每个被试做的组数
times_per_group=96;


 %所有被试每组实验的准确率和反应时间均值
correctavg=zeros(Subjects_num,groups_num); 
latencyavg=zeros(Subjects_num,groups_num);

%每个被试所有组实验的准确率和反应时间数据
correct_per_subj=zeros(groups_num,times_per_group);
latency_per_subj=zeros(groups_num,times_per_group);

% Files = dir(fullfile( path,'*.*'));
Files = dir(fullfile( path));
LengthFiles = length(Files);

subj_count=0;

for iCount = 1:LengthFiles    % 判断是否是文件夹    
    name = Files(iCount).name;    
    if name=='.'        
       continue;    
    end
    s = [path  '\' name '\'];        %遍历文件   
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
  
    %将每个被试的数据转换成列模式保存，便于origin处理
   tcorrect=correct_per_subj'
   tlatency=latency_per_subj';
   correctfilename=['correct_' name '.mat'];
   save([savepath,correctfilename],'tcorrect');
   latencyfilename=['latency_'  name '.mat'];
   save([savepath,latencyfilename],'tlatency');
       
   subj_count=subj_count+1;
   
   %将每个被试每组实验的准确率和反应时间均值保存起来
   correctavg(subj_count,:)=mean(tcorrect,1);
   latencyavg(subj_count,:)=mean(tlatency,1);    
  end
%  计算每组correct和latency均值。   
correctavgfilename=['correctavg_of_all_subjs' '.mat'];
save([savepath,correctavgfilename],'correctavg');
latencyavgfilename=['latencyavg_of_all_subjs' '.mat'];
save([savepath,latencyavgfilename],'latencyavg');
