clear all
close all
clc

filenames = dir('*.dat');
for i = 1:((length(filenames)))
    WAV_name = filenames(i).name;
    fid=fopen(WAV_name,'rb');
    errmsg = '';
    while fid < 0
    disp(errmsg);
    [fid,errmsg] = fopen(WAV_name);
    end
    fseek(fid,0,'eof');
    NBytes=ftell(fid);
    fseek(fid,0,'bof');
    Xchar=fread(fid,NBytes,'uchar'); 
    for i1=1:1000
        Str=(char(Xchar(i1:i1+3)))';
        if strcmp(Str,'data')
            break;
        end
    end
    i1=i1+7;
    fseek(fid,i1,'bof');
    NSig=(NBytes-i1);
    Signal=fread(fid,NSig,'int16');
    N = length(Signal);
    i1 = 1:3:45000;
    i2 = 2:3:45000;
    i3 = 3:3:45000;
    S(:,1) = Signal(i1);
    S(:,2) = Signal(i2);
    S(:,3) = Signal(i3);
    Lname = length(WAV_name)-4;
    new_ecg_name = ['new_ecg/' WAV_name(1:Lname) '.csv'];
    csvwrite(new_ecg_name,S)
    
%     save(new_ecg_name,'S','-ascii'); 
%     fileID = fopen(new_ecg_name,'w');
%     fprintf(fileID,'%d\r\n',S);
%     fclose(fileID);
end
    
    