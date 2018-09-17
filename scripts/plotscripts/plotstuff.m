## Plotting script

hold on

## Plot coastline

shapedraw(coastline,'k',"LineWidth",2);
grid

## Plot actions
plot([datasorted1set.londec],[datasorted1set.latdec],...
                                             "ro;Mi-14PS;", 'markersize', 10,...
     [datasorted2set.londec],[datasorted2set.latdec],...
                                             "bo;W3-RM;", 'markersize', 10);


## Plot bases
colors=["m^;EPDA;";"r^;EPOK;";"y^;Dziwnow;"];
for i=1:3
    fig1 = plot(data.base(i).londec, data.base(i).latdec, colors(i,:),...
    'markersize', 12, 'markerfacecolor','auto');
endfor
clear colors

#Plot contours of intensity estimator
contourf(gridlon,gridlat,intensity_estimator);
hold on
shapedraw(coastline,'k',"LineWidth",2);
colorbar

## Test plot them uniform poisson point process
plot(x_unif,y_unif,"*")

####4
## Make a clean plot
clf
hold on
colormap("cool");
shapedraw(coastline,'k',"LineWidth",2);
grid on
colors=["m^;EPDA;";"r^;EPOK;";"y^;Dziwnow;"];

for i=1:3
    fig1 = plot(data.base(i).londec,data.base(i).latdec, colors(i,:),...
    'markersize', 12, 'markerfacecolor','auto');
endfor
plot([datasorted1set.londec],[datasorted1set.latdec],...
                                             "ro;Mi-14PS;", 'markersize', 8,'linewidth',2,...
     [datasorted2set.londec],[datasorted2set.latdec],...
                                             "bo;W3-RM;", 'markersize', 8,'linewidth',2);
contourf(gridlon{1},gridlat{1},intensity_estimator{1});
plot(x_sim{1},y_sim{1},"kx;Symulacja;",'markersize',8, 'linewidth',1);

#Plot actions associated with base2dec

colors=["mo;akcjeEPDA;";"ro;akcjeEPOK;";"yo;akcjeDziwnow;"];
for i=1:number_of_potential_sites
    plot(  [x_sim{1}(action_idx{i})],[y_sim{1}(action_idx{i})],colors(i,:),"markersize",8,"markerfacecolor","auto"   )
endfor




