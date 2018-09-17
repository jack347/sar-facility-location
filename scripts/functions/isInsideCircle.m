function retval = isInsideCircle (xi,yi,x0,y0,bandwidth)
dx = abs(xi-x0);
dy = abs(yi-y0);

if dx > bandwidth
    retval = false;
    return
endif

if dy > bandwidth
    retval = false;
    return
endif

if dx+dy <= bandwidth
    retval = true;
    return
endif

if dx^2+dy^2 <= bandwidth^2
    retval = true;
    return
  else
    retval = false;
    return
endif


endfunction