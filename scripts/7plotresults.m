## Measure time preformance
time_performance(7).what = 'Plot Results';
time_performance(7).id = tic;

## Make a clean plot of results WIP
clf
hold on
colormap("cool");
shapedraw(coastline,'k',"LineWidth",2);
grid on
colors=["m^;EPDA;";"r^;EPOK;";"y^;Dziwnow;";"g^;Swinoujscie;";"b^;Kołobrzeg;";"c^;Ustka;";"k^;Łeba;"];

for i=1:number_of_potential_sites
    fig1 = plot(data.base(i).londec,data.base(i).latdec, colors(i,:),...
    'markersize', 12, 'markerfacecolor','auto');
endfor
plot([datasorted1set.londec],[datasorted1set.latdec],...
                                             "ro;Mi-14PS;", 'markersize', 8,'linewidth',2,...
     [datasorted2set.londec],[datasorted2set.latdec],...
                                             "bo;W3-RM;", 'markersize', 8,'linewidth',2);
contourf(gridlon{1},gridlat{1},intensity_estimator{1});
plot(x_sim{1},y_sim{1},"kx;Symulacja;",'markersize',10, 'linewidth',2);

#Plot actions associated with base2dec

colors=["mo;akcjeEPDA;";"ro;akcjeEPOK;";"yo;akcjeDziwnow;";"go";"bo";"co";"ko"];
for i=1:number_of_potential_sites
    plot(  [x_sim{1}(action_idx{i})],[y_sim{1}(action_idx{i})],colors(i,:),"markersize",8,"markerfacecolor","auto"   )
endfor




time_performance(7).duration = toc(time_performance(7).id);
