function data = loadbv_data(filename,hdr,srange,chans)
%% calculate the datapoints
fullname = [filename,'.eeg'];
IN = fopen(fullname,'r');
fseek(IN, 0, 'eof');
datapoints = ftell(IN) / (hdr.nchan * hdr.bps);
fseek(IN, 0, 'bof');

%% chan info
if ~exist('chans', 'var')
    chans = 1:hdr.nchan;
    nbchan = hdr.nchan;
elseif isempty(chans)
    chans = 1:hdr.nchan;
    nbchan = hdr.nchan;
else
    nbchan = length(chans);
end
if any(chans < 1) || any(chans > hdr.nchan)
    error('chans out of available channel range');
end

%% Sample range
if ~exist('srange', 'var') || isempty(srange)
    srange = [1,datapoints];
    pnts = datapoints;
elseif length(srange) == 1
    pnts = datapoints - srange(1) + 1;
else
    pnts = srange(2) - srange(1) + 1;
end
if any(srange < 1) || any(srange > datapoints)
    error('srange out of available data range');
end


%% read data
switch hdr.ori
    case 'multiplexed'
        if nbchan == hdr.nchan % Read all channels
            fseek(IN, (srange(1) - 1) * nbchan * hdr.bps, 'bof');
            data = fread(IN, [nbchan, pnts], [hdr.binformat '=>float32']);
        else % Read channel subset
            data = repmat(single(0), [nbchan, pnts]); % Preallocate memory
            for chan = 1:length(chans)
                fseek(IN, (srange(1) - 1) * hdr.nchan * hdr.bps + (chans(chan) - 1) * hdr.bps, 'bof');
                data(chan, :) = fread(IN, [1,pnts], [hdr.binformat '=>float32'], (hdr.nchan - 1) * hdr.bps);
            end
        end
    case 'vectorized'
        if isequal(pnts, datapoints) && nbchan == hdr.nchan % Read entire file
            data = fread(IN, [pnts, nbchan], [hdr.binformat '=>float32']).';
        else % Read fraction of file
            data = repmat(single(0), [nbchan, pnts]); % Preallocate memory
            for chan = 1:length(chans)
                fseek(IN, ((chans(chan) - 1) * datapoints + srange(1) - 1) * hdr.bps, 'bof');
                EEG.data(chan, :) = fread(IN, [1,pnts], [hdr.binformat '=>float32']);
            end
        end
    otherwise
        error('Unsupported data orientation')
end
fclose(IN);
%% scale the data
for chan = 1:nbchan
    data(chan, :) = data(chan, :) * hdr.scale(chans(chan));
end