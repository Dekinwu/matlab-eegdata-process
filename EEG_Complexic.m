%������ʵ���Ե��źŷ�������������--���Ӷȵļ���%
%����  ���ϴ�ѧ����ҽѧ����ҽѧͼ�����źŴ���ʵ����   %
%E-mail: wanhualin01@163.com%
%2008��3��10��%
function Kc=EEG_Complexic(data)
c=1;
%EEG=EEG_data0; %del by wu
EEG=data;  %added by wu
BIN_EEG=zeros(1,length(EEG));%��ʼ������������
SUM_EEG=sum(EEG(1:length(EEG)));
MEAN_EEG=SUM_EEG/length(EEG);
for i=1:length(EEG)  %�Ե��źŴ�����
      if (EEG(i)>=MEAN_EEG)
          BIN_EEG(i)=1;
      elseif(EEG(i)<MEAN_EEG)
          BIN_EEG(i)=0;
      end
end
S=[BIN_EEG(1)];Q=[BIN_EEG(2)];
%for i=1:length(BIN_EEG)-2
while((length(S)+length(Q))<length(BIN_EEG))
SQ=[S Q];
SQD=SQ(1:length(SQ)-1);
isbelong = 0;
for r=1:length(SQD)-length(Q)+1  %�ж�Q�Ƿ���SQD���Ӵ�
   Sr=SQD(r:r+length(Q)-1);
       if(Sr==Q) 
          isbelong = 1; %Q�Ƿ���SQD���Ӵ�
       end
end
if(isbelong == 1)
   Q=[Q BIN_EEG(length(SQ)+1)];                                
 elseif(isbelong == 0)
   c=c+1;
   S=[S Q];
   Q=BIN_EEG(length(S)+1);  
end
end
 %���һ��Q�Ƿ������Ӵ�������c+1
SQ=[S Q];
SQD=SQ(1:length(SQ)-1);
isbelong = 0;
for r=1:length(SQD)-length(Q)+1  %�ж�Q�Ƿ���SQD���Ӵ�
   Sr=SQD(r:r+length(Q)-1);
       if(Sr==Q) 
          isbelong = 1; %Q�Ƿ���SQD���Ӵ�
       end
end
if(isbelong == 0)
   c=c+1;
end
b=length(BIN_EEG)/(log2(length(BIN_EEG)));
Kc=c/b;
return

