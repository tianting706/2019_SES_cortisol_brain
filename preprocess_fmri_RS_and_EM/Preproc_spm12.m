% Written by Hao (2017/07/12)
% haol.psy@gmail.com
% Qinlab.BNU

restoredefaultpath
clear
clc
%% ------------------------------ Set Up ------------------------------- %%
% Set Path
addpath (genpath ('/brain/iCAN/SPM/spm12')); % path of SPM toolbox
addpath (genpath ('/brain/iCAN/home/tianting/script/Preproc_spm12/')); % path of this script;upper directory

SubList    = '/brain/iCAN/home/tianting/script/Preproc_spm12/SWU_RS.txt'; % path of subject list of each task
PreprocDir = '/brain/iCAN/data/'; % path of data after pre-processing
WorkDir    = pwd;

% Set Basic Information
fmriName   = {'REST'}; % For emotion matching task:{'EM'}
TR         = 2;
T1Filter   = 'I';
FuncFilter = 'I';
DataType   = 'nii';
SliceOrder = [1:2:33 2:2:32]; 

%% Import SubList
fid      = fopen(SubList);
ID_List  = {};
Cnt_List = 1;
while ~feof(fid)
    linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
    ID_List(Cnt_List,:) = linedata{1}; %#ok<*SAGROW>
    Cnt_List = Cnt_List + 1;
end
fclose(fid);

% -------------------------- Preprocess fmri -------------------------- %%
SliceTiming = 'a > ar'; Realign = 'r > c'; Normalise = 'w'; Smooth = 's'.
for run = 1:length(fmriName)
    for i = 1:length(ID_List)
        YearID = ['20',ID_List{i,1}(1:2)];
        SubDir = ID_List{i};
        disp ([SubDir,' Preprocess Started'])
        
        T1Dir     = fullfile(PreprocDir,YearID,SubDir,'/mri/anatomy/');
        FuncDir   = fullfile(PreprocDir,YearID,SubDir,'/fmri/',fmriName{run,1},'/unnormalized/');
        FinalDir = fullfile(PreprocDir,YearID,SubDir,'/fmri/',fmriName{run,1},'/smoothed_spm12/');
        
        cd (FuncDir)
        Step1_Script (FuncDir,FuncFilter,T1Dir,T1Filter,SliceOrder,TR,DataType);
        Step2_Script (FuncDir,FuncFilter,T1Dir,T1Filter,SliceOrder,TR,DataType);
        
        rpFile        = fullfile(FuncDir,'rp_arI.txt');
        MeanFile      = fullfile(FuncDir,'meanarI.nii');
        VlmRep_GS     = fullfile(FuncDir,'VolumRepair_GlobalSignal.txt');
        SmoothFile    = fullfile(FuncDir,'swcarI.nii');
        NoSmoothFile  = fullfile(FuncDir,'wcarI.nii');
        
        mkdir (FinalDir)
        movefile(rpFile,FinalDir)
        movefile(MeanFile,FinalDir)
        movefile(VlmRep_GS,FinalDir)
        movefile(SmoothFile,FinalDir)
        movefile(NoSmoothFile,FinalDir)
    end
end

%% ------------------------- Movement Exclusion ------------------------ %%
cd (WorkDir)
for k = 1:length(fmriName)
    mConfigName = ['Config_MoveExclu_',fmriName{k,1},'.m'];
    mConfig = fopen (mConfigName,'a');
    fprintf (mConfig,'%s\n',['paralist.ServerPath = ''',PreprocDir,''';']);
    fprintf (mConfig,'%s\n','paralist.PreprocessedFolder = ''smoothed_spm12'';');
    
    fprintf (mConfig,'%s\n',['fid = fopen(''',SubList,''');']);
    fprintf (mConfig,'%s\n','ID_List = {};');
    fprintf (mConfig,'%s\n','Cnt_List = 1;');
    fprintf (mConfig,'%s\n','while ~feof(fid)');
    fprintf (mConfig,'%s\n','linedata = textscan(fgetl(fid), ''%s'', ''Delimiter'', ''\t'');');
    fprintf (mConfig,'%s\n','ID_List(Cnt_List,:) = linedata{1};');
    fprintf (mConfig,'%s\n','Cnt_List = Cnt_List + 1;');
    fprintf (mConfig,'%s\n','end');
    fprintf (mConfig,'%s\n','fclose(fid);');
    
    fprintf (mConfig,'%s\n','paralist.SubjectList = ID_List;');
    fprintf (mConfig,'%s\n',['paralist.SessionList = {''',fmriName{k,1},'''};']);
    fprintf (mConfig,'%s\n','paralist.ScanToScanCrit = 0.5;');
    
    MoveExclu_spm12_Hao(mConfigName)
end
    mkdir ('Res&Log')
    movefile ('Log*.txt','Res&Log')
    movefile ('Config*.m','Res&Log')
%% All Done
clear
disp ('All Done');
