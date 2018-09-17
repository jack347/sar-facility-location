## Script creating intensity function estimator lambda(x) 
## Add path to functions
addpath("./functions/");
## Measure time preformance
time_performance(3).what = 'Creating Intensity function estimator';
time_performance(3).id = tic;

## for inhomogenous Poisson process
page_output_immediately(1) #see immediate output_max_field_width
more off #disable more piping

## Create square grid

# Define number of divisions in each direction
ndiv = [100];
# Define bandwidth values used in generating intensity estimator
# Bandwidth is a vector of values in degrees decimal
bandwidth = [0.2];

# Create divisions
for i=1:length(ndiv)
    grid1d{i} = [linspace(0,1,ndiv(i)+1)];

    # Scale the grid to latitude and longitude

    gridlon{i} = (bbox(1,2)-bbox(1,1))*grid1d{i} + bbox(1,1);
    gridlat{i} = (bbox(2,2)-bbox(2,1))*grid1d{i} + bbox(2,1);

    [XX{i}, YY{i}] = meshgrid(gridlon{i}, gridlat{i});

    ## Calculate distance between points on grid in km

    printf("Ndiv = %d ===> Grid spacing %.4f km.\n Bandwidth vector",...
            ndiv(i), deg2km(gridlat{i}(2)-gridlat{i}(1)));
    disp(bandwidth);

endfor



#! Write for loop generating n estimators, where n is the number of bandwidth given
for i=1:length(ndiv)
    for j=1:length(bandwidth)
         intensity_estimator{i,j}(:,:) = estimate_intensity2(XX{i}, YY{i},...
                                                     [data.action(:).londec],...
                                                     [data.action(:).latdec],...
                                                      bandwidth(j));
    endfor
endfor
#Clearing junk
clear grid1d
#End time measurement
time_performance(3).duration = toc(time_performance(3).id);

