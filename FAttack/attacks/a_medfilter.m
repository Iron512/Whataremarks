function dsFun = a_medfilter(direction)
function aimg = downfn(image, factor)
    factor=factor^2;
    [width, height] = size(image);
    if mod(direction, 2) > 0 
        w = 1+floor(factor*(width-1));
    else
        w = 1;
    end
    if (direction > 1)
        h = 1+floor(factor*(height-1));
    else
        h = 1;
    end
    %fprintf("%d - %d\n", w, h);
    aimg = medfilt2(image,[w, h]);
end
dsFun = @downfn;
end


