function chan = load_channel(filename)
fid = fopen(filename ,'r', 'l');
fseek(fid,370,'bof');
nchannels = fread(fid,1,'ushort');
fseek(fid,900,'bof');
chan = cellstr(deblank(char(fread(fid,[10,nchannels],'10*char',75-10)')));
frewind(fid);
fclose(fid);