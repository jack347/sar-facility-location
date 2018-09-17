#Subplot generation

## Make a 2 by 3 subplot

#Which mesh?
i=1
#! make matrix for POS
#posit=[[[[linspace(0,0.5,4)]',repmat(0.5,5,1)];[[linspace(0,0.8,5)]',repmat(0,5,1)]],repmat(0.2,10,1),repmat(0.5,10,1)];
posit=[0,0.5,0.5,0.5;0.5,0.5,0.5,0.5;0,0,0.5,0.5;0.5,0,0.5,0.5];


for i=1:length(ndiv)
    figure(i)
for j=1:length(bandwidth)
    
    #subplot(2,2,j,"align", "position",posit(j,:))
    subplot(1,2,j)
    contourf(gridlon{i},gridlat{i},intensity_estimator{i,j}(:,:));
    shapedraw(coastline,'k',"LineWidth",2);
    grid
    colorbar
    colormap("cool");
    hold
    plot(x_sim{i,j},y_sim{i,j},"kx",'markersize',8, 'linewidth',2);
endfor
endfor


figure(2)
for i=1:length(bandwidth)
    subplot(2,3,i, "align")
       
    stem3(XX,YY,intensity_estimator(:,:,i));
    
    colormap("cool");
endfor