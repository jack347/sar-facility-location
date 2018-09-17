## Simulate Poisson point process (inhomogenous)
## Determine lambdastar - intensity of a homogenous Poisson Process (PP)
## It is maximum intensity found on intensity_map, higher value can be chosen
## but this would lead to a inefficient simulation since some more points 
## would have to be rejected.

## Measure time preformance
time_performance(4).what = 'Simulating Poisson point process';
time_performance(4).id = tic;

#Initialize some variables
lambdastar = N = zeros(length(ndiv),length(bandwidth));

for i=1:length(ndiv)
    for j=1:length(bandwidth)
    lambdastar(i,j) = max(max(intensity_estimator{i,j}));

    ## Generate Poisson random variable =  number of points to be generated for a Homogenous PP,
    ## the characteristic value is the mean number of points
    N(i,j) = poissrnd(lambdastar(i,j) * (bbox(1,2)-bbox(1,1))*(bbox(2,2)-bbox(2,1)));

    ## Simulate N uniformly distributed random points

    x_unif{i,j} = (rand(N(i,j),1) * (max(gridlon{i})-min(gridlon{i})))+ min(gridlon{i});
    y_unif{i,j} = (rand(N(i,j),1) * (max(gridlat{i})-min(gridlat{i})))+ min(gridlat{i});

    ## Thinning data according to intensity estimator function
    ## Interpolating intensity estimator for random point locations using default
    ## linear interpolation
    intensity_est_interp{i,j} = interp2(gridlon{i},gridlat{i},...
                                      intensity_estimator{i,j}(:,:),...
                                      x_unif{i,j},y_unif{i,j});


    ## Create thinning function (probability measure of retaining a point)
    thinning_function_p{i,j} = intensity_est_interp{i,j}/lambdastar(i,j);

    ## Obtain thinning index of those points whose thinning function is higher than 
    ## random generated number (i.e.roll)
    thinned_index{i,j} = find( rand(N(i,j),1) < thinning_function_p{i,j} );

    ## Create simulated point coordinates
    x_sim{i,j} = x_unif{i,j}(thinned_index{i,j});
    y_sim{i,j} = y_unif{i,j}(thinned_index{i,j});
    printf("### %d points generated for #%d bandwidth = %.4f deg = %.4f km ### \n",...
                  length(x_sim{i,j}),j, bandwidth(j), deg2km(bandwidth(j)));

    endfor
endfor

time_performance(4).duration = toc(time_performance(4).id);



