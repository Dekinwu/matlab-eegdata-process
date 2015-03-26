function data = load_data(filename,varargin)
%   -------------------------- IN ------------------------------------
%   channels (optional)     ->  vector of channel numbers to load or string 'all'.
%                               [default = 'all']                   
%   range (optional)        ->  2-element vector containing start and stop points
%                               (inclusive) or string 'all' [default =
%                               'all']
%--------------------------------------------------------------------------

%---------------------readnum---------------------------------
fid = fopen(filename,'r', 'l');

fseek(fid,370,'bof');
numChan = fread(fid,1,'ushort');

fseek(fid,886,'bof');
eventPos = fread(fid,1,'long');

dataPos = 900+(75*numChan);
numSamples = ((eventPos - dataPos)/numChan)/4;

fseek(fid,947,'bof');
baseline = fread(fid,numChan,'short',75-2)';

fseek(fid,959,'bof');
sensitivity = fread(fid,numChan,'float',75-4)';

fseek(fid,971,'bof');
calibration = fread(fid,numChan,'float',75-4)';
%--------------------------------------------------------
% --------------- Set Channels & Ranges -----------------
if (nargin == 1)
    channels = 'all';
    range = 'all';
elseif (nargin == 2)
    channels = varargin{1};
    range = 'all';
elseif  (nargin == 3)
    channels = varargin{1};
    range = varargin{2};
end

if isa(range,'char') & (range == 'all')
    start = 0;
    numPoints = numSamples;
    range = [1 numSamples];
else
    start = (range(1)-1)*numChan*4;
    numPoints = range(2)-range(1)+1;
end
%-------------------------------------------------------------
% -------Must check than range is within numSamples!----------
if isa(channels,'char') & (channels == 'all')
    channels = [1:numChan];
else
    channels = sort(channels);
    index = [];
    for i = 1:length(channels)-1
        if (channels(i) == channels(i+1))
            index = [index i+1];
        end
    end
    channels(index) = [];
end
%------------------------------------------------------------
% ------------------- Read Data -----------------------------

if (length(channels) < numChan)
    data = zeros(numPoints,length(channels));
    for i = 1:length(channels)
        fseek(fid,dataPos+start,'bof');
        fseek(fid,(channels(i)-1)*4,'cof');
        data(:,i) = fread(fid,numPoints,'int32',(numChan-1)*4);
    end
elseif (length(channels) == numChan)
    fseek(fid,dataPos+start,'bof');
    data = zeros(numChan,numPoints);
    data = fread(fid,[numChan,numPoints],'int32');
    data = data';
end
% --------------- scale to microvolts -----------------------------

scaleFactor = ((sensitivity .* calibration)./204.8);
scaleFactor = scaleFactor(ones(size(data,1),1),channels);
baseline = baseline(ones(size(data,1),1),channels);

data = (data - baseline) .* scaleFactor;

frewind(fid);
fclose(fid);