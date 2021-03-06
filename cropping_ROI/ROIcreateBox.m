function bh = ROIcreateBox(dimensions,location,ax)
%creates box in current or parsed axis with specified width and
%height at the location loc. 
%Output is handle to the object for later manipulation.

% get axis if necessary
if not(exist('ax','var'))
    ax = gca;
end

% default location is [0, 0, 0]
if ~exist('loc','var')
    location = [0, 0, 0];
end

vertices = [...
    0 0 0;... idx 1 for x axis coloring
    1 0 0;... idx 2 
    1 1 0;... idx 3
    0 1 0;... idx 4 for y axis coloring
    0 0 1;... idx 5 for z axis coloring
    1 0 1;... idx 6
    1 1 1;... idx 7
    0 1 1]; % idx 8
vertices = vertices - 1/2; % centering cube
vertices(:,1) = vertices(:,1) * dimensions(1); % scale xx
vertices(:,2) = vertices(:,2) * dimensions(2); % scale yy
vertices(:,3) = vertices(:,3) * dimensions(3); % scale zz
vertices = vertices + repmat(location,8,1);

faces = [... order is such that rgb coloring of axis is correct
    1 2 3 4;...
    8 4 3 7;...
    1 2 6 5;...
    8 5 6 7;...
    6 7 3 2;...
    4 1 5 8;...
    ];
    

% plotting of pathc object
bh = patch(ax,'Vertices',vertices,'Faces',faces);
bh.FaceColor = [.5 , .5 , .5];
bh.FaceAlpha = 0.5;
bh.DisplayName = 'ROI box';

% defining reference coordinate system
bh.UserData.ROIzaxis = [location ; location + [0,0,dimensions(1)]];
bh.UserData.ROIyaxis = [location ; location + [0,dimensions(2),0]];
bh.UserData.ROIxaxis = [location ; location + [dimensions(3),0,0]];

% coloring of vertices
cols = [...
    1, 0, 0;... x axis coloring
    0, 0, 0;... 
    0, 0, 0;...
    0, 1, 0;... y axis coloring
    0, 0, 1;... z axis coloring
    0, 0, 0;...
    0, 0, 0;...
    0, 0, 0;];
bh.FaceVertexCData = cols;
bh.EdgeColor = 'flat';
bh.LineWidth = 2;
