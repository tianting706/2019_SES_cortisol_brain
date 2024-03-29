% SWUEM_gPPI('SWUEM_gPPI_config.m')
% Configuration file for gPPI.m
% Shaozheng Qin adapted for his poject on January 1, 2014
% Lei Hao adapted for his poject on September 12, 2017
%=========================================================================%
clear
restoredefaultpath

% Set Path
SPM_Dir    = '/brain/iCAN/toolbox/SPM/spm8';
Script_Dir = '/brain/iCAN/home/tianting/script/gPPI';

% % Please specify the data server path
% paralist.data_server = '/brain/iCAN/home/tianting/preprocessed/Preprocessed1st/SWU_ALL/';

% added by genghaiyang specify the stats server path
paralist.server_path_stats = '/brain/iCAN/home/tianting/firstlevel/firstlevel_ses/';

% Please specify the parent folder of the static data
% For YEAR data structure, use the first one
% For NONE YEAR data structure, use the second one
paralist.parent_folder = '';

% Please specify the subject list file (.txt) or a cell array
subjlist = fullfile(Script_Dir, 'sublist.txt');

% Please specify the stats folder name (eg., stats_spm8)
paralist.stats_folder = '/EM/stats_spm8_swcar';

% get ROI file list
ROI_form = 'nii';
paralist.roi_nii_folder = '/brain/iCAN/home/tianting/script/gPPI/ROI/Nii';

% Please specify the task to include
% set = { '1', 'task1', 'task2'} -> must exist in all sessions
% set = { '0', 'task1', 'task2'} -> does not need to exist in all sessions
paralist.tasks_to_include = {'1', 'emotion','control'};

% Please specify the confound names
paralist.confound_names = {'R1', 'R2', 'R3', 'R4', 'R5', 'R6'};

% make T contrast
    Pcon.Contrasts(1).left      = {'emotion'};
    Pcon.Contrasts(1).right     = {'none'};
    Pcon.Contrasts(1).STAT      = 'T';
    Pcon.Contrasts(1).Weighted  = 0;
  % Pcon.Contrasts(1).MinEvents = 5;
    Pcon.Contrasts(1).name      = 'emotion';
    
    Pcon.Contrasts(2).left      = {'control'};
    Pcon.Contrasts(2).right     = {'none'};
    Pcon.Contrasts(2).STAT      = 'T';
    Pcon.Contrasts(2).Weighted  = 0;
  % Pcon.Contrasts(2).MinEvents = 5;
    Pcon.Contrasts(2).name      = 'control';
    
    Pcon.Contrasts(3).left      = {'emotion'};
 	  Pcon.Contrasts(3).right     = {'control'};
    Pcon.Contrasts(3).STAT      = 'T';
    Pcon.Contrasts(3).Weighted  = 0;
  % Pcon.Contrasts(3).MinEvents = 5;
    Pcon.Contrasts(3).name      = 'emovscon';

%% ===================================================================== %%
% Acquire Subject list
fid = fopen (subjlist);
paralist.subject_list = {};
Cnt_List = 1;
while ~feof (fid)
    linedata = textscan (fgetl (fid), '%s', 'Delimiter', '\t');
    paralist.subject_list (Cnt_List, :) = linedata {1}; %#ok<*SAGROW>
    Cnt_List = Cnt_List + 1;
end
fclose (fid);

% Acquire ROI file & list
ROI_list = dir (fullfile (paralist.roi_nii_folder, ['*.', ROI_form]));
ROI_list = struct2cell (ROI_list);
ROI_list = ROI_list (1, :);
ROI_list = ROI_list';

paralist.roi_file_list = {};
for roi_i = 1:length (ROI_list)
paralist.roi_file_list {roi_i,1} = fullfile (paralist.roi_nii_folder, ROI_list {roi_i, 1});
end

paralist.roi_name_list = strtok (ROI_list, '.');

% Add Path
addpath (genpath (SPM_Dir));
addpath (genpath (Script_Dir));