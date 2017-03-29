function KlustaKwikDecisionWindow()
%
% KKClustDecisionWindow
%
% NCST and ADR
% May 2002

% ADR fixed displayprogress -> DisplayProgress

global KKClust
global MClust_KKDecisionWindow_Pos KlustaKwik_Clusters
global MClust_Directory

%--------------------
% Alignment variables

uicWidth = 0.20;
uicWidtfigHandle = 0.05;
uicWidth1 = 0.10;
uicHeight = 0.05;
XLocs = [0.1 0.4:uicWidth1:0.9];
dY = uicHeight;
YLocs = 0.9:-dY:0.1;
dx = 1/400;
dy= 1/300;
xg = 0:dx:1;
yg = 0:dy:1; 

%-------------------------------
% figure

figHandle = figure(...
   'Name', 'KlustaKwik Cluster Decision Window',...
   'NumberTitle', 'off', ...
   'Tag', 'KKDecisionWindow', ...
   'HandleVisibility', 'Callback',...
   'CreateFcn', 'KlustaKwikCallbacks',...  
   'KeyPressFcn', 'KlustaKwikKeyPress', ...
   'Position', MClust_KKDecisionWindow_Pos);

cmap = 1-copper(length(KlustaKwik_Clusters)+round(length(KlustaKwik_Clusters)/6)+1); 
cmap = cmap(max(1,round(length(KlustaKwik_Clusters)/6)):end,:);

% Top left buttons

bw = 100*dx;
bh = 10 *dy;
ix = 10;                % ix =[1,400]  (left, right)
iy = 270;              % iy =[1,300]  (bottom, top)

% EXPORT
% find types
availableTypes = dir(fullfile(MClust_Directory, 'ClusterTypes', '@*'));
availableTypes = {availableTypes.name};
uicontrol('Parent', figHandle,...
   'Style', 'text', 'String', 'Export as...', ...
   'Units', 'Normalized', 'Position', [xg(ix) yg(iy)+2*bh bw bh]);
ui_featuresIgnoreLB =  uicontrol('Parent', figHandle,...
   'Units', 'Normalized', 'Position', [xg(ix) yg(iy)-0*bh bw bh*2],...
   'Style', 'listbox', 'Tag', 'ExportAsType',...
   'HorizontalAlignment', 'right', ...
   'String', availableTypes,...
   'Max', 1, 'Min', 1, 'value', strmatch('@precut', availableTypes),...
   'Enable','on', ...
   'TooltipString', 'Type to export as.');

h1 = uicontrol('Parent',figHandle, ...
	'Units','normalized', ...
	'Callback','KlustaKwikCallbacks', ...
	'ListboxTop',0, ...
	'Position',[xg(ix) yg(iy)-4*bh bw 2*bh], ...
	'String','Export w/ ColorMerge', ...
	'Tag','ExportClustersMerge', ...
	'TooltipString','Export clusters to MClust, merging clusters with the same color');
h1 = uicontrol('Parent',figHandle, ...
	'Units','normalized', ...
	'Callback','KlustaKwikCallbacks', ...
	'ListboxTop',0, ...
	'Position',[xg(ix) yg(iy)-2*bh bw 2*bh], ...
	'String',{'Export unmerged'}, ...
	'Tag','ExportClustersSeparate', ...
	'TooltipString','Export clusters to MClust');
h1 = uicontrol('Parent',figHandle, ...
	'Units','normalized', ...
	'Callback','KlustaKwikCallbacks', ...
	'ListboxTop',0, ...
	'Position',[xg(ix) yg(iy)-5*bh bw bh], ...
	'String',{'Export as single cluster'}, ...
	'Tag','ExportClustersOne', ...
	'TooltipString','Export clusters to MClust, merged into a single cluster');

% % EXIT
% 
h1 = uicontrol('Parent',figHandle, ...
	'Units','normalized', ...
	'Callback','KlustaKwikCallbacks', ...
	'ListboxTop',0, ...
	'Position',[xg(ix) yg(iy)-6*bh bw bh], ...
	'String','Quit without export', ...
	'Tag','Exit', ...
	'TooltipString','Close Window while keeping all data structures still in memory');

%---------------------------------------------------------------------
uicWidth = 0.30;
uicWidth0 = 0.05;
uicWidth1 = 0.10;
uicHeight = 0.04;
XLocs = 0.3;
dY = uicHeight;
YLocs = 0.95:-dY:0.1;
global MClust_FeatureNames

uicontrol('Parent', figHandle, 'Units', 'Normalized', 'Position', [0.29 0.99-(7*uicHeight+0.01) uicWidth+0.02 7*uicHeight+0.02], ...
   'Style', 'Frame');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1) YLocs(1)+uicHeight/3 uicWidth0 2/3*uicHeight], ...
   'Style', 'text', 'String', ' X: ');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth0 YLocs(1) uicWidth-uicWidth0 uicHeight],...
   'Style', 'popupmenu', 'Tag', 'xdim', 'String', MClust_FeatureNames, ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 1, ...
   'TooltipString', 'Select x dimension');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1) YLocs(2)+uicHeight/3  uicWidth0 2/3*uicHeight], ...
   'Style', 'text', 'String', ' Y: ');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth0 YLocs(2) uicWidth-uicWidth0 uicHeight],...
   'Style', 'popupmenu', 'Tag', 'ydim', 'String', MClust_FeatureNames, ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 2, ...
   'TooltipString', 'Select y dimension');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1) YLocs(3)+uicHeight/3  uicWidth0 2/3*uicHeight], ...
   'Style', 'text', 'String', ' Z: ');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth0 YLocs(3) uicWidth-uicWidth0 uicHeight],...
   'Style', 'popupmenu', 'Tag', 'zdim', 'String', MClust_FeatureNames, ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 3, ...
   'TooltipString', 'Select z dimension');

uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1) YLocs(5) uicWidth/2 uicHeight],...
   'Style', 'checkbox', 'Tag', 'View2D', 'String', 'View 2D', ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 0, ...
   'TooltipString', 'View 2D plot (X by Y)');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1) YLocs(6) uicWidth/2 uicHeight],...
   'Style', 'checkbox', 'Tag', 'View3D', 'String', 'View 3D', ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 0, ...
   'TooltipString', 'View 3D plot (X by Y x Z)');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1) YLocs(7) uicWidth/2 uicHeight],...
   'Style', 'checkbox', 'Tag', 'ViewContour', 'String', 'Contour', ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 0, ...
   'TooltipString', 'View contour plot (X by Y)');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth/2 YLocs(5) uicWidth/2 uicHeight],...
   'Style', 'checkbox', 'Tag', 'Show0', 'String', 'Show all points', ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 1, ...
   'TooltipString', 'Show all points');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth/2 YLocs(6) uicWidth/2 uicHeight],...
   'Style', 'checkbox', 'Tag', 'ShowKeeps', 'String', 'Show keeps', ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 0, ...
   'TooltipString', 'Show all points in KEEP clusters');
uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth/2 YLocs(7) uicWidth/2 uicHeight],...
   'Style', 'ToggleButton', 'Tag', 'Rotate3D', 'String', 'Rotate3D', ...
   'Callback', 'KlustaKwikCallbacks', 'Value', 0, 'Enable', 'off', ...
   'TooltipString', 'Rotate 3D plot through 360 deg. (if 3D plot being shown)');

%----------------------------------------------------------------------------------------
% current cluster box
bw = 120*dx;
bh = 8 *dy;
ix = 10;                % ix =[1,400]  (left, right)
iy = 170;              % iy =[1,300]  (bottom, top)

h1 = uicontrol('Parent',figHandle, ...
	'Units','normalized', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'ListboxTop',0, ...
	'Position',[xg(ix)-3*dx yg(iy)-5*bh bw+6*dx+0.3 9*bh+3*dy], ...
	'Style','frame', ...
	'Tag','Frame1');

global MClust_TTfn

if ~isempty(MClust_TTfn)
    [p n e] = fileparts(MClust_TTfn);
else
    n = [];
end

h1 = uicontrol('Parent',figHandle, ...
	'Units','normalized', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'Position',[xg(ix) yg(iy)+2*bh bw+0.3 bh*1.5], ...
	'String',{['Tetrode ' n]; 'CURRENT CLUSTER'}, ...
	'Style','text', ...
	'Tag','Text_CURRENT_cluster');

h1 = uicontrol('Parent',figHandle, ...
	'Units','normalized', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'HorizontalAlignment','left', ...
	'Position',[xg(ix) yg(iy)-3*bh 3*bw/4+0.3 5*bh], ...
	'String',' ', ...
	'Style','text', ...
	'Tag','StatisticsText');

% axes
bw = 120*dx;
bh = 10 *dy;
ix = 10;                % ix =[1,400]  (left, right)
iy = 80;              % iy =[1,300]  (bottom, top)

% MClust_AverageWaveform_ylim - added 3.5 ncst
global MClust_AverageWaveform_ylim;
h1 = axes('Parent',figHandle, ...                 % AVERAGE WAVEFORM AXIS
	'Units','normalized', ...
	'CameraUpVector',[0 1 0], ...
	'CameraUpVectorMode','manual', ...
	'Color',[1 1 1], ...
	'Position',[xg(ix) yg(iy) bw+0.3 5*bh], ...
	'Tag','AverageWaveformAxis', ...
	'TickDirMode','manual', ...
	'Visible','off', ...
	'XColor',[0 0 0], ...
	'XLim',[0 140], ...
	'XLimMode','manual', ...
	'YColor',[0 0 0], ...
	'YLim',MClust_AverageWaveform_ylim, ...
	'YLimMode','manual', ...
	'ZColor',[0 0 0]);

h1 = axes('Parent',figHandle, ...                    % ISI AXIS
	'Units','normalized', ...
	'Box','on', ...
	'CameraUpVector',[0 1 0], ...
	'CameraUpVectorMode','manual', ...
	'Color',[1 1 1], ...
	'Position',[xg(ix) yg(iy)-7*bh bw+0.3 6*bh], ...
	'Tag','ISIHistAxis', ...
	'XColor',[0 0 0], ...
	'XLim',[0.5 1], ...
	'XLimMode','manual', ...
	'XScale','log', ...
	'YColor',[0 0 0], ...
	'YLim',[0.37 0.62], ...
	'YLimMode','manual', ...
	'YTick',38, ...
	'YTickMode','manual', ...
	'ZColor',[0 0 0]);

drawnow;

%-----------------------------------------------------------------
% Draw clusters

% labels
width = 0.05; height = 0.05; 
uicontrol('Parent', figHandle, 'Units', 'Normalized', 'Position', [0.39+0.3 0.0 5*width+0.02 0.99], ...
   'Style', 'Frame');
uicontrol('Parent', figHandle, 'Units', 'Normalized', 'Position', [0.4+0.3 0.95 width height], ...
   'Style', 'Text', 'String', 'HOLD');
uicontrol('Parent', figHandle, 'Units', 'Normalized', 'Position', [0.4+0.3+4*width 0.95 width height], ...
   'Style', 'Text', 'String', 'KEEP');

global KlustaKwik_AllHold
global KKC_IDSet
KlustaKwik_AllHold = [];
KKC_IDSet = {};

KlustaKwik_AllHold = zeros(length(KlustaKwik_Clusters), 1);
KKC_IDSet = cell(length(KlustaKwik_Clusters), 1);
KKCperPage = 35;
for iC = 1:length(KlustaKwik_Clusters)   
    [HoldID, KKC_IDSet{iC}] = CreateKKClusterKeys(figHandle, iC, ...
        0.7, 0.95 - 0.025 * (mod(iC-1,KKCperPage)), cmap, ceil(iC/KKCperPage));
    KlustaKwik_AllHold(iC) = HoldID;
    if KKC_IDSet{iC}.page == 1
        for iK = 1:length(KKC_IDSet{iC}.ui)
            set(KKC_IDSet{iC}.ui(iK), 'visible', 'on', 'enable', 'on');
        end
    else
        for iK = 1:length(KKC_IDSet{iC}.ui)
            set(KKC_IDSet{iC}.ui(iK), 'visible', 'off', 'enable', 'off');
        end
    end                
end
for iC = 1:length(KlustaKwik_Clusters)
    set(KlustaKwik_AllHold(iC), 'UserData', {iC, KlustaKwik_AllHold});
end

%------------------------------------------------------------------------
% Added Title to Display -- JCJ Sept 2007
nKKC=length(KlustaKwik_Clusters);
DisplayProgress(0,nKKC,'Title',['Processing ' num2str(nKKC) ' pre-clusters'] );
for iC = 1:nKKC
    KlustaKwikStatistics(iC);
    DisplayProgress(iC,nKKC,'Title',['Processing ' num2str(nKKC) ' pre-clusters'] );
end
DisplayProgress close % Added close of display -- JCJ Sept 2007

% calculate waveform correlation matrix
% modified ncst 20 May 02 to use waveforms from all valid channels

global MClust_ChannelValidity

WVs = zeros(length(KlustaKwik_Clusters), sum(MClust_ChannelValidity) * size(KKClust.WaveForms{1},2));
for iC = 1:length(KlustaKwik_Clusters)
    WV = KKClust.WaveForms{iC};
    wfm = WV{1};
    ChannelIndex = 1;
    for iCh = find(MClust_ChannelValidity)
        WVs(iC,(ChannelIndex - 1)*size(wfm,2) + 1:ChannelIndex*size(wfm,2)) = wfm(iCh,:);
        ChannelIndex = ChannelIndex + 1;
    end
end
   
KKClust.WaveFormCorr = [];
   
KKClust.WaveFormCorr = corrcoef(WVs').^3;

KlustaKwikCallbacks('SelectCluster', findobj(figHandle,'Tag','SelectCluster','UserData',1));

%------------------------------------------------------------------------
function [HoldID, KKC_IDSet] = CreateKKClusterKeys(figHandle, iC, XLoc, YLoc, cmap, pageNumber)
width = 0.05;
height = 0.025; 
CallbackFunc = 'KlustaKwikCallbacks';

% Hold
HoldID = uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLoc YLoc width height], ...
   'Style', 'radiobutton', 'Tag', 'HoldCluster', ...
   'Value', 0, 'UserData', {iC}, ...
   'Callback', CallbackFunc, ...
   'TooltipString', 'Hold Cluster.');
KKC_IDSet.ui(1) = HoldID;

% color 
KKC_IDSet.ui(2) = uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLoc+width YLoc width height], ...
   'Style', 'PushButton', 'BackgroundColor', cmap(iC+1,:), ...
   'Tag', 'ChooseColor', 'UserData', iC, 'Callback', CallbackFunc, ...
   'TooltipString', 'Change cluster color');

% ID
KKC_IDSet.ui(3) = uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLoc+2*width YLoc width height], ...
   'Style', 'PushButton',  ...
   'Tag', 'SelectCluster', 'UserData', iC, 'Callback', CallbackFunc, ...
   'KeyPressFcn', 'KlustaKwikKeyPress', ...
   'String', num2str(iC),'BackgroundColor',get(0,'defaultuicontrolbackgroundcolor'));

% Corr
KKC_IDSet.ui(4) = uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLoc+3*width YLoc width height], ...
   'Style', 'Text',  ...
   'Tag', 'Correlation', 'UserData', iC, ...
   'String', '----');

% keep/trash
KKC_IDSet.ui(5) = uicontrol('Parent', figHandle, ...
   'Units', 'Normalized', 'Position', [XLoc+4*width YLoc width height], ...
   'Style', 'checkbox', 'Tag', 'KeepCluster', ...
   'Value', 0, 'UserData', iC, ...
   'Callback', CallbackFunc, ...
   'TooltipString', 'Keep cluster Y/N');

% Page
KKC_IDSet.page = pageNumber;

