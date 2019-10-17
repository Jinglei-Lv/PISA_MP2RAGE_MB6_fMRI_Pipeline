% script to load onsets for repeated news clips 
% Inputs:
%   lfile1  - Presentation logfile of the 1st viewing
%   lfile2  - Presentation logfile of the 2nd viewing
% 
% Outputs
%   onsets  - onsets of the video clips
%   names   - name of each clip
%   durations - durations of each clip
%   cons    - contrast between continue clips vs novel clips
function [onsets,names,markers,durations,cons]=load_news_viewing(lfile1,lfile2)

[EventType1,Code1,Time1,VideoStim1,Videofiles1,Duration1] = importfile_Presentation_log(lfile1);   
[EventType2,Code2,Time2,VideoStim2,Videofiles2,Duration2] = importfile_Presentation_log(lfile2);

viewing1 = Videofiles1(ismember(VideoStim1,'Video'));
viewing2 = Videofiles2(ismember(VideoStim2,'Video'));

N = numel(viewing2);
is_repeat = zeros(1,N);
for i=1:N
    ff = viewing2{i};
    ff = strrep(ff,'_2.avi','_1.avi');
    ff = strrep(ff,'Set2','Set1');
    is_repeat(i) = ismember(ff,viewing1);
end

clear onsets durations names
onsets = cell(1,N);    
names  = cell(1,N);
markers = cell(1,N);
durations   = cell(1,N);

idx = find(ismember(EventType2,'Video'));
ridx = find(ismember(VideoStim2,'Video'));
for i=1:N
    onsets{i} = Time2(idx(i));
    
    NN = Videofiles2{ridx(i)};
    NN = strrep(NN,'\','/');
    [~,NN] = fileparts(NN);
    if is_repeat(i), mm = 'R'; 
    else mm = 'N'; end;
    names{i} = NN;
    markers{i}= mm;
    ff = find(ismember(VideoStim2,Videofiles2{ridx(i)}));    
    durations{i} = Duration2(ff);        
end

% contrast
cons = [];
cons(1).n = 'Repeat';
cons(1).w = is_repeat;    

is_novel = 1-is_repeat;
cons(2).n = 'Novel';
cons(2).w = 1-is_repeat;

cons(3).n = 'Repeat_vs_Novel';
cons(3).w = is_repeat - is_novel;

cons(4).n = 'Novel_vs_Repeat';
cons(4).w = is_novel-is_repeat;
