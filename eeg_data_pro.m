
filename_pre='..\实验数据\CES脑电\EEGdata\zhx\sh_zhx_0316\sh_zhx_pre.cnt';
spec_result_name=strrep(filename_pre,'.cnt','.mat');%'../实验数据/CES脑电\EEGdata\ly\stim_ly_0313\ly_post.mat'

%filename='zx_closeac.cnt'
channum=18;
[spec_pre,freqs]=chan_speccomp(filename_pre,{'F1','FZ','F2','FC1','FCZ','FC2','C1','CZ','C2','CP1','CPZ','CP2','P1','PZ','P2','PO3','POZ','PO4'});
save('spec_result_name','spec_pre');

filename_post='..\实验数据\CES脑电\EEGdata\zhx\sh_zhx_0316\sh_zhx_post.cnt';
spec_result_name=strrep(filename_post,'.cnt','.mat');%spec_result_name='../实验数据/CES脑电\EEGdata\ly\stim_ly_0313\ly_post.mat'
[spec_post,freqs]=chan_speccomp(filename_post,{'F1','FZ','F2','FC1','FCZ','FC2','C1','CZ','C2','CP1','CPZ','CP2','P1','PZ','P2','PO3','POZ','PO4'});
save('spec_result_name','spec_post');

figure;
for i=1:channum
plot(freqs(1:64),spec_pre(i,1:64));%'r','LineWidth',2);
hold on;
end
legend('PRE_F1','PRE_FZ','PRE_F2','PRE_FC1','PRE_FCZ','PRE_FC2','PRE_C1','PRE_CZ','PRE_C2','PRE_CP1','PRE_CPZ','PRE_CP2','PRE_P1','PRE_PZ','PRE_P2','PRE_PO3','PRE_POZ','PRE_PO4');
hold on;
for i=1:channum
plot(freqs(1:64),spec_post(i,1:64));%,'g','LineWidth',2);
hold on;
end
legend('POST_F1','POST_FZ','POST_F2','POST_FC1','POST_FCZ','POST_FC2','POST_C1','POST_CZ','POST_C2','POST_CP1','POST_CPZ','POST_CP2','POST_P1','POST_PZ','POST_P2','POST_PO3','POST_POZ','POST_PO4');