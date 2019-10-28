function dsFun = a_downscale(direction)
function downscaled = downfn(image, factor)
    factor=factor^2;
    [width, height] = size(image);
    if mod(direction, 2) > 0 
        w = round(width-(factor*(width-1)));
    else
        w = width;
    end
    if (direction > 1)
        h = round(height-(factor*(height-1)));
    else
        h = height;
    end
    %fprintf("%d - %d\n", w, h);
    downscaled = imresize(imresize(image, [h, w]),[height, width]);
end
dsFun = @downfn;
end


