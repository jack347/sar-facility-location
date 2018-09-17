## Script preparing map
## Load neccesary packages
pkg load mapping octclip geometry

## Measure script run time
time_performance = struct(...
                          'id',0,...
                          'what','',...
                          'duration',0);
                          
time_performance(1).what = 'Map Preparation';
time_performance(1).id = tic;

## Specify map file location
mapfileloc='../input/coastline/ne_10m_coastline.shp';

## Specify bounding box [MinX, MaxX; MinY, MaxY]
bbox = [13,20;53,57];

##Read the map data
[coastline] = shaperead(mapfileloc,0,'BoundingBox',bbox,'Clip',1);

## Cleaning junk
clear mapfileloc

## End time measurement
time_performance(1).duration = toc(time_performance(1).id);