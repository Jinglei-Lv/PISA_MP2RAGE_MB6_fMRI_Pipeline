
function parselog(logfile1,logfile2,TR,rmvolnum,outdir)
    %logfile1='PISA_063568-Viewing_1_FLAIR_Manual.log';
    %logfile2='PISA_063568-Viewing_2_fMRI.log';
    evmatch=load('EV_videoname_match.mat');
    %TR=0.82;
    %rmvolnum=10;

    [onsets,names,markers,durations,cons]=load_news_viewing(logfile1,logfile2)
    evmatch=struct2cell(evmatch);
    evmatch=evmatch{1};

    stdid=zeros(size(names));
    for i=1:size(names,2)
        for j=1:size(evmatch,1)
            if strcmp(names{i},evmatch{j,2})
                stdid(i)=j;
            end
        end
    end

    nonsets=onsets;
    for j=1:numel(onsets) 
        nonsets{j} = onsets{j} - TR*rmvolnum;
    end

    nmarkers=markers;
    for i=1:length(stdid)
        nmarkers{stdid(i)}=markers{i};
    end


    ncons=cons;
    for i=1:size(ncons,2)
       ncons(i).w(stdid)=ncons(i).w;
    end



    for i=1:length(stdid)
        fname=[outdir,'/','EV',num2str(stdid(i)),'.txt'];
        m=[nonsets{i},durations{i},1];
        dlmwrite(fname,m,'\t')

    end

    fname=[outdir,'/','Markers.txt']
    fid=fopen(fname,'w');
    for i=1:length(stdid)
        fprintf(fid,'%s ',nmarkers{i});
    end
    fclose(fid);

    % fname=['Contrast_tag.txt']
    % fid=fopen(fname,'w');
    % for i=1:size(ncons,2)
    %     fprintf(fid,'%s\n',ncons(i).n);
    % end
    % fclose(fid);



    fname=[outdir,'/','EV_Video_match.txt']
    fid=fopen(fname,'w');
    for i=1:size(evmatch,1)
        fprintf(fid,'%s\t%s_%s\n',evmatch{i,1},nmarkers{i},evmatch{i,2});
    end
    fclose(fid);

    wall=zeros(36,18);
    for i=1:size(ncons,2)
        wall(i,:)=ncons(i).w;
    end
    wall(5,1:10)=1;
    wall(6,11:18)=1;
    wall(7,1:10)=1;
    wall(7,11:18)=-1;
    wall(8,:)=-wall(7);
    wall(9,[3:10,15:18])=1;
    wall(10,[1:2,11:14])=1;
    wall(11,:)=wall(9,:)-wall(10,:);
    wall(12,:)=-wall(11,:);
    wall(13,[1,3,4,11,15])=1;
    wall(14,[2,6])=1;
    wall(15,[7,8,17,18])=1;
    wall(16,[5,16])=1;
    wall(17,[9,12,13])=1;
    wall(18,[10,14])=1;
    for i=1:18
        wall(18+i,i)=1;
    end
    fname=[outdir,'/','Contrast_mat.txt']
    dlmwrite(fname,wall,' ');

    fname=[outdir,'/','Contrast_title.txt']
    fid=fopen(fname,'w');
    fprintf(fid,'Repeat\n');
    fprintf(fid,'Novel\n');
    fprintf(fid,'R-N\n');
    fprintf(fid,'N-R\n');
    fprintf(fid,'F\n');
    fprintf(fid,'M\n');
    fprintf(fid,'F-M\n');
    fprintf(fid,'M-F\n');
    fprintf(fid,'Pos\n');
    fprintf(fid,'Neg\n');
    fprintf(fid,'P-N\n');
    fprintf(fid,'N-P\n');
    fprintf(fid,'Animal\n');
    fprintf(fid,'Local\n');
    fprintf(fid,'Politics\n');
    fprintf(fid,'Bussiness\n');
    fprintf(fid,'Science\n');
    fprintf(fid,'Sports\n');
    for i=1:size(evmatch,1)
        fprintf(fid,'%s_%s\n',nmarkers{i},evmatch{i,2});
    end
    fclose(fid);
end









