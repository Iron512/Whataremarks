function res = plot_attack_3d(plotFunction, limits, steps)
    
    xstep = (limits(2)-limits(1))/steps;
    ystep = (limits(4)-limits(3))/steps;
    steps=steps+1;
    xs = zeros(steps, steps);
    ys = zeros(steps, steps);
    zs = zeros(steps, steps);
    cs = zeros(steps, steps);
    xstart = limits(1);
    ystart = limits(3);
    for i=1:steps
        for j=1:steps
            x = xstart+(i-1).*xstep;
            y = ystart+(j-1).*ystep;
            xs(i,j) = x;
            ys(i,j) = y;
            value = plotFunction([x,y]);
            res = 0;
            zs(i,j) = value;
            cs(i, j) = res.*128+256;
        end
    end
    res = surf(xs, ys, zs, cs);
end