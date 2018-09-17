function [intensity_map] = estimate_intensity(XX, YY, lon, lat, bandwidth)
ndiv = length(XX)-1;
location = [lon;lat]';
## Initialize countmap
countmap = zeros(ndiv+1); #initialize map of values
printf("Countmap initialized.");
## Call the function that checks if point is inside bandwidth circle
for i=1:(ndiv+1)
    for j=1:(ndiv+1)
        pointcount = 0;
        for k=1:length(location)
            if (...
                isInsideCircle(...
                               location(k,1), location(k,2),...
                               XX(i,j), YY(i,j), bandwidth...
                               )...
                == true...
                )
                pointcount++;
            endif
        endfor
        countmap(i,j)=pointcount;
        printf("Point count for node (%d,%d) is %d. Bandwidth = %.4f\n",i,j,pointcount,bandwidth);
    endfor
endfor

## Calculate intensity function estimator on grid points
kernel_area = pi*bandwidth^2;
intensity_map = countmap/kernel_area;

endfunction