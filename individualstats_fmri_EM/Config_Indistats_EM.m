paralist.YourName = 'tianting2';
paralist.data_type = 'nii';
paralist.pipeline = 'swcar';
paralist.server_path = '/home/qinlab/data/userdata/tianting/Preprocessed/Preprocessed1st/SWU_ALL';
paralist.stats_path = '/home/qinlab/data/userdata/tianting/FirstLevel/SWU_1st_all';
paralist.parent_folder = '';
fid = fopen('/home/qinlab/data/userdata/tianting/CPSWU_script/FirstLevel2/FirstLevel/FirstLv_spm12new/SWU_1st_all_114.txt');
SubLists = {};
Cnt_List = 1;
while ~feof(fid)
    linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
    SubLists(Cnt_List,:) = linedata{1}; %#ok<*SAGROW>
    Cnt_List = Cnt_List + 1;
end
fclose(fid);
paralist.subjectlist = SubLists;
paralist.exp_sesslist = 'EM';
paralist.task_dsgn = 'taskdesign_emotion_xjh.m';
paralist.contrastmat = '/home/qinlab/data/userdata/tianting/CPSWU_script/FirstLevel2/FirstLevel/FirstLv_spm12new/Contrast/contrasts_EM_XJH.mat';
paralist.preprocessed_folder = 'smoothed_spm12';
paralist.stats_folder = 'EM/stats_spm8_swcar';
paralist.include_mvmnt = 1;
paralist.include_volrepair = 0;
paralist.volpipeline = 'swavr';
paralist.volrepaired_folder = 'volrepair_spm12';
paralist.repaired_stats = 'stats_spm12_VolRepair';
paralist.template_path = '/home/qinlab/data/userdata/tianting/CPSWU_script/FirstLevel2/FirstLevel/FirstLv_spm12new/Dependence';
paralist.YourName = 'tianting2';
paralist.data_type = 'nii';
paralist.pipeline = 'swcar';
paralist.server_path = '/home/qinlab/data/userdata/tianting/Preprocessed/Preprocessed1st/SWU_ALL';
paralist.stats_path = '/home/qinlab/data/userdata/tianting/FirstLevel/SWU_1st_all';
paralist.parent_folder = '';
fid = fopen('/home/qinlab/data/userdata/tianting/CPSWU_script/FirstLevel2/FirstLevel/FirstLv_spm12new/Copy_of_SWU_1st_all_114.txt');
SubLists = {};
Cnt_List = 1;
while ~feof(fid)
    linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
    SubLists(Cnt_List,:) = linedata{1}; %#ok<*SAGROW>
    Cnt_List = Cnt_List + 1;
end
fclose(fid);
paralist.subjectlist = SubLists;
paralist.exp_sesslist = 'EM';
paralist.task_dsgn = 'taskdesign_emotion_xjh.m';
paralist.contrastmat = '/home/qinlab/data/userdata/tianting/CPSWU_script/FirstLevel2/FirstLevel/FirstLv_spm12new/Contrast/contrasts_EM_XJH.mat';
paralist.preprocessed_folder = 'smoothed_spm12';
paralist.stats_folder = 'EM/stats_spm8_swcar';
paralist.include_mvmnt = 1;
paralist.include_volrepair = 0;
paralist.volpipeline = 'swavr';
paralist.volrepaired_folder = 'volrepair_spm12';
paralist.repaired_stats = 'stats_spm12_VolRepair';
paralist.template_path = '/home/qinlab/data/userdata/tianting/CPSWU_script/FirstLevel2/FirstLevel/FirstLv_spm12new/Dependence';
