#Perform some statistics on data
## Measure time preformance
time_performance(5).what = 'Data statistics';
time_performance(5).id = tic;


stats = struct(...
               'no_pts',[],...
               'x_sim_mean',[],...
               'y_sim_mean',[],...
               'r_sim',{},...
               'r_sim_mean',[],...
               'x_sim_std_dev',[],...
               'y_sim_std_dev',[],...
               'r_sim_std_dev',[]...
               );


for i=1:length(ndiv)
    for j=1:length(bandwidth)
        stats(i,j).no_pts = length(x_sim{i,j});
    stats(i,j).x_sim_mean = mean(x_sim{i,j});
    stats(i,j).y_sim_mean = mean(y_sim{i,j});
         stats(i,j).r_sim = sqrt(x_sim{i,j}.^2+y_sim{i,j}.^2);
    stats(i,j).r_sim_mean = mean(stats(i,j).r_sim);
    
    stats(i,j).x_sim_std_dev = sqrt( (sum((x_sim{i,j}.-stats(i,j).x_sim_mean).^2))/(stats(i,j).no_pts));
    stats(i,j).y_sim_std_dev = sqrt( (sum((y_sim{i,j}.-stats(i,j).y_sim_mean).^2))/(stats(i,j).no_pts) );
    stats(i,j).r_sim_std_dev = sqrt( (sum((stats(i,j).r_sim.-stats(i,j).r_sim_mean).^2))/(stats(i,j).no_pts) );
    
    endfor
endfor

time_performance(5).duration = toc(time_performance(5).id);
