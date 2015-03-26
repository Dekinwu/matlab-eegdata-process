function event = loadbv_event(filename)
fullname = [filename,'.vmrk'];
fid = fopen(fullname);
str = fread(fid,'*char');
fclose(fid);
pat = 'Stimulus,S\s*(\d*),(\d*),';
cel = regexp(str',pat,'tokens');
event = zeros(length(cel),2);
for i = 1:length(cel)
    for j = 1:2
    event(i,j) = str2double(cel{i}{j});
    end
end