% 运行该脚本，可以从实验数据文件中提取出每个被试的反应时间和准确率并保存在相应目录的相应文件下，
%将生成的文件导入origin，可以进行相关统计分析。
%使用该脚本时，请正确的输入原始数据所在目录和处理后的数据保存的目录。

% 心理旋转实验数据所在目录
path='F:\课题\CES实验数据及处理\实验数据\CES行为学\RT_time\theta';
% 处理后数据保存目录
savepath='F:\课题\CES实验数据及处理\实验数据\CES行为学\rt_matlab_result\theta\';
Subjects_num=10;   %被试的个数
groups_num=8;  %每个被试做的组数
times_per_group=96;


 %所有被试实验前后的平均准确率和平均反应时间
correctavg=zeros(Subjects_num,2); 
latencyavg=zeros(Subjects_num,2);

%每个被试所有组实验的准确率和反应时间数据
correct_per_subj=zeros(1,groups_num*times_per_group);
latency_per_subj=zeros(1,groups_num*times_per_group);

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
    s_down=(i-1)*times_per_group+1;
    s_up=i*times_per_group;
    correct_per_subj(1,s_down:s_up)=data.subject.Correct;
    latency_per_subj(1,s_down:s_up)=data.subject.Latency;
    end 
   
   %剔除错误反应下的反应时间数据
   for iCount=1:groups_num*times_per_group
           if(correct_per_subj(1,iCount) == -1 )
               latency_per_subj(1,iCount)=0;
           end
   end
   %剔除刺激前后反应时间小于200ms的点
   pre_latency=latency_per_subj(1:groups_num*times_per_group/2);
   post_latency=latency_per_subj((1+groups_num*times_per_group/2):(groups_num*times_per_group));
   pre_more200=find(pre_latency>0.2);
   post_more200=find(post_latency>0.2);
   
   pre_latency_r1=pre_latency(pre_more200);
   post_latency_r1=post_latency(post_more200); %得到大于200ms的数据
   
    %剔除高于平均反应时三个标准差的数据
   pre_meanla=mean(pre_latency_r1);
   pre_varla=std(pre_latency_r1,0,2);
   post_meanla=mean(post_latency_r1);
   post_varla=std(post_latency_r1,0,2);
   
   less3var_pre=find( pre_latency_r1 < (pre_meanla+3*pre_varla) );
   less3var_post=find( post_latency_r1 < (post_meanla+3*post_varla) );
   
   pre_latency_final=pre_latency_r1(less3var_pre);
   post_latency_final=post_latency_r1(less3var_post);  %得到最终提取的数据
   
   
   subj_count=subj_count+1;
   
   %将每个被试实验前后的准确率和反应时间均值保存起来
   % pre_correct=correct_per_subj(1:groups_num*times_per_group/2);
   correctavg(subj_count,1)=mean( correct_per_subj(1:groups_num*times_per_group/2) );
   correctavg(subj_count,2)=mean( correct_per_subj((1+groups_num*times_per_group/2):(groups_num*times_per_group)));
   latencyavg(subj_count,1)=mean(pre_latency_final); 
   latencyavg(subj_count,2)=mean(post_latency_final);
end
  

%  保存所有被试实验前后的平均准确率和平均反应时间。   
correctavgfilename=['correctavg_of_all_subjs' '.mat'];
save([savepath,correctavgfilename],'correctavg');
latencyavgfilename=['latencyavg_of_all_subjs' '.mat'];
save([savepath,latencyavgfilename],'latencyavg');


%将所有被试实验前后的平均反应时间增长率保存  ，增长率定义为Post-pre/pre
ratelatency=( latencyavg(:,2)-latencyavg(:,1) ) ./latencyavg(:,1) *100;

%保存所有人的增长率
rateavgfilename=['rateavg_of_all_subjs' '.mat'];
save([savepath,rateavgfilename],'ratelatency');

ratelat_meanla=mean(ratelatency);
ratelat_varla=std(ratelatency,0,1);

ratelatrefine1=find( (ratelat_meanla-3*ratelat_varla)<ratelatency );

ratelatfinal1=ratelatency(ratelatrefine1);
latencyavgrefine1=latencyavg(ratelatrefine1,:);

ratelatrefine2=find( ratelatfinal1 < (ratelat_meanla+3*ratelat_varla) );

ratefinal=ratelatfinal1(ratelatrefine2);  %最终得到增长率在两倍标准差之内的数据
latencyavgfinal=latencyavg(ratelatrefine2,:); %相应的前后反应时间。

%保存经过被试刷选后的平均增长率和前后反应时间
latavgfinalfilename=['latavgfinal_of_all_subjs' '.mat'];
save([savepath,latavgfinalfilename],'latencyavgfinal');
ratefinalfilename=['ratefinal_of_all_subjs' '.mat'];
save([savepath,ratefinalfilename],'ratefinal');







