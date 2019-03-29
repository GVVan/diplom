function Signal=Extract_Sig_WAV(WAV_name)

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
i1 = 1:3:N;
i2 = 2:3:N;
i3 = 3:3:N;
S(:,1) = Signal(i1);
S(:,2) = Signal(i2);
S(:,3) = Signal(i3);