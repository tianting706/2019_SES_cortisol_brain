clear;
clc;

subid=[6];%sublist
subname={'16-07-23.2SWUP1'};
ss1_enc_in='/home/qinlab/data/userdata/tianting/CPSWU_script/task_design/sublist_eprime.txt';
DataPath1='/home/qinlab/data/userdata/tianting/Preprocessed/Preprocessed2nd/2018/';
trailsflag=70;

%+++++++++++Need to change before++++++++++++
temp=size(subid');
%Per subject 60 trails
trails=60;
%Subnum
M=temp(1);
%Per block 6 trails
TrailNum=6;

%Config 
EFields = {'Subject';'Slide1.OnsetTime';'type'};
%EFields = {'Subject';'Slide1.OnsetTime';'type';'Slide1.RT';'Slide1.RTTime';'Slide1.ACC';'Slide1.CRESP'}; 

DataPath2='/fmri/EM/task_design/taskdesign_emotion_xjh.m';
ss1_enc_out =strcat(ss1_enc_in, '_out.txt');
fid=fopen(ss1_enc_in);     

RawData = {};
    cnt = 1;
    while ~feof(fid)
      linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
      RawData(cnt,:) = linedata{1}; %#ok<*AGROW>
      cnt = cnt+1;
    end
    fclose(fid);
%Print cnt and RawData
cnt;
RawData;  
indices={};
          
for i = 1:numel(EFields)
    %Get RawData's colum number; size(RawData,1) is the row number
            for j = 1:size(RawData,2)
                if (strcmpi(EFields{i}, RawData{1,j}))
                    indices{i} = j;
                    
                end
            end          
        end   
%Print indices   
indices;

 if (exist(ss1_enc_out,'file'))
     delete(ss1_enc_out);
 end
 fid = fopen(ss1_enc_out, 'a');

 for i = 2:cnt - 1
            for j = 1:size(EFields,1)
                                  
                    name = RawData{i,indices{j}};
                    fprintf(fid, '%s\t',name);
            end

            fprintf(fid, '\n');
        end

        fclose(fid);    
        
Edat=load(ss1_enc_out);
[Edatrows Edatcols]=size(Edat);

for k=1:M
    
 for j=1:MxSubid
    
    if subid(k)==j
        tmpSubid=Edat(:,1);
        loc=find(tmpSubid'==j);
        subjectid=Edat(loc,1);
        OnsetTime=Edat(loc,2);
        Type=Edat(loc,3);
        k
        j
        subjectid
[ trail,tmpcol]=size(loc) ;

        if(j==subjectid(1))
          index=find(subid==j);
          Outputtaskdesignpathtmp=strcat(DataPath1, subname(index),DataPath2);
          Outputtaskdesignpath=cell2mat(Outputtaskdesignpathtmp);
          Outputtaskdesignpath
          
          break; 
                 
        end
    end

end   

OnsetTime=OnsetTime-OnsetTime(1);
onsets1=[];
onsets2=[];
emotiontype=find(Type==11);
controltype=find(Type==22);
sizetask=size(emotiontype);
sizecontrol=size(controltype);
if (sizetask(1)+sizecontrol(1)==trails)
    if (Type(1)==11)
        for i=1:sizetask(1)/(TrailNum)
            onsets1(i)=OnsetTime(emotiontype(1+TrailNum*(i-1)));
        end
        for i=1:sizecontrol(1)/(TrailNum)
            onsets2(i)=OnsetTime(controltype(1+TrailNum*(i-1)));
        end
    else
        (Type(1)==22)
        for i=1:sizecontrol(1)/(TrailNum)
            onsets2(i)=OnsetTime(controltype(1+TrailNum*(i-1)));
        end
        for i=1:sizetask(1)/(TrailNum)
            onsets1(i)=OnsetTime(emotiontype(1+TrailNum*(i-1)));
        end
    end
           
else
     fprintf('Error: not fit for this taskdesign \n');
end
onsets1=onsets1/1000;
onsets2=onsets2/1000;

Outputtaskdesignpath

if (exist(Outputtaskdesignpath,'file'))
     delete(Outputtaskdesignpath);
end

if(fopen(Outputtaskdesignpath,'a'))
    
fp=fopen(Outputtaskdesignpath,'a');

fprintf(fp, '%s\n', 'sess_name =''Emotion Block'';');

fprintf(fp, '%s\n','names{1}     = [''emotion''];');

fprintf(fp, '%s','onsets{1}    = [');

for i =1:sizetask(1)/(TrailNum)
    fprintf(fp, '%.3f', onsets1(i));
    fprintf(fp, '%s', ',');
end

fprintf(fp, '%s\n','];');

fprintf(fp, '%s','durations{1} = [');

for i =1:sizetask(1)/(TrailNum)
    fprintf(fp, '%d', 30);
    fprintf(fp, '%s', ',');
end

fprintf(fp, '%s\n','];');
fprintf(fp, '%s\n','names{2}     = [''control''];');

fprintf(fp, '%s','onsets{2}    = [');

for i =1:sizecontrol(1)/(TrailNum)
    fprintf(fp, '%.3f', onsets2(i));
    fprintf(fp, '%s', ',');
end

fprintf(fp, '%s\n','];');

fprintf(fp, '%s','durations{2} = [');

for i =1:sizecontrol(1)/(TrailNum)
    fprintf(fp, '%d', 30);
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');
fprintf(fp, '%s\n','rest_exists  = 1;');

fprintf(fp, '%s\n','save task_design.mat sess_name names onsets durations rest_exists');

fclose(fp); 

else
    break
end
end

fprintf('Finish taskdesign \n');
