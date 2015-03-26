function event = load_event(filename)
fid = fopen(filename,'r', 'l');

%% nachannels
fseek(fid,370,'bof');
numChan = fread(fid,1,'ushort');

%% seek eventspos
fseek(fid,886,'bof');
eventPos = fread(fid,1,'long');

%% seek eventsize and offset
fseek(fid,eventPos+1,'bof');
eventSize   = fread(fid,1,'long');
eventOffset = fread(fid,1,'long');

%% read event
fseek(fid,eventPos + 9 + eventOffset,'bof');
stimType = fread(fid,eventSize/19,'short',19-2);

fseek(fid,eventPos + 9 + eventOffset + 4,'bof');
stimOffset = fread(fid,eventSize/19,'long',19-4);

stimOffset = stimOffset - (900 + (75 * numChan));
stimOffset = stimOffset ./ (4 * numChan)+1;

event_org = [stimType stimOffset];
[event(:,2),b] = unique(event_org(:,2), 'first');
event(:,1)     = event_org(b,1);
frewind(fid);
fclose(fid);