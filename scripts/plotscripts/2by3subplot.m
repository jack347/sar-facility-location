## Make a 2 by 3 subplot

for i=1:length(bandwidth)
    subplot(2,3,i, "position")
       
    contourf(gridlon,gridlat,intensity_estimator(:,:,i));
    shapedraw(coastline,'k',"LineWidth",2);
    grid
    colorbar
    colormap("cool");
    hold
    plot(x_sim{i},y_sim{i},"kx;Symulacja;",'markersize',8, 'linewidth',2);
endfor

figure(2)
for i=1:length(bandwidth)
    subplot(2,3,i, "align")
       
    stem3(XX,YY,intensity_estimator(:,:,i));
    
    colormap("cool");
endfor