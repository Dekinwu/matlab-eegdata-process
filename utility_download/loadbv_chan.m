function [chan,varargout] = loadbv_chan(filename)
fullname = [filename,'.vhdr'];
fid = fopen(fullname);
flag      = 1;
writeflag = 0;
str = [];
while flag
    getl = fgetl(fid);
    if strcmp(getl,'[Channel Infos]')
        writeflag = 1;
    elseif strcmp(getl,'[Comment]')
        writeflag = 0;
        flag      = 0;
    elseif strmatch('NumberOfChannels',getl)
        equalpoi  = strfind(getl,'=');
        hdr.nchan = str2double(getl(equalpoi+1:end));
    elseif strmatch('SamplingInterval',getl)
        equalpoi  = strfind(getl,'=');
        hdr.srate = 1000000/str2double(getl(equalpoi+1:end));
    elseif strmatch('DataOrientation',getl)
        equalpoi  = strfind(getl,'=');
        hdr.ori = lower(getl(equalpoi+1:end));
    elseif strmatch('BinaryFormat',getl)
        equalpoi  = strfind(getl,'=');
        format = lower(getl(equalpoi+1:end));
        switch format
            case 'int_16',        hdr.binformat = 'int16';   hdr.bps = 2;
            case 'uint_16',       hdr.binformat = 'uint16';  hdr.bps = 2;
            case 'ieee_float_32', hdr.binformat = 'float32'; hdr.bps = 4;
            otherwise, error('Unsupported binary format');
        end
    end
    
    if writeflag == 1;
        str = [str,getl];
    end
end
fclose(fid);

pat = 'Ch\d+=(\w+),(\w*),(\d*\.\d*|\d*),';
cel = regexp(str,pat,'tokens');
chan = cell(length(cel),1);
for i = 1:length(cel)
    chan{i} = upper(cel{i}{1});
    hdr.scale(i) = str2double(cel{i}{3});
end

if nargout == 2
    varargout{1} = hdr;
end
