function [intensity_map] = estimate_intensity(XX, YY, lon, lat, bandwidth)
ndiv = length(XX)-1;
location = [lon;lat]';
## Initialize countmap
countmap = zeros(ndiv+1); #initialize map of values
printf("Countmap initialized.");
## Call the function that checks if point is inside bandwidth circle

for k=1:length(location)
    dx = abs(location(k,1)-XX(:,:));
    dy = abs(location(k,2)-YY(:,:));
    pointdetect=(dx.^2+dy.^2 <= bandwidth.^2);
    countmap.+=(dx.^2+dy.^2 <= bandwidth.^2);
    printf("Point #%d (%.4f,%.4f) found %d times. Bandwidth = %.4f\n",...
           k,location(k,1),location(k,2),sum(sum(pointdetect)),bandwidth);
endfor
    


## Calculate intensity function estimator on grid points
kernel_area = pi*bandwidth^2;
intensity_map = countmap/kernel_area;

endfunction