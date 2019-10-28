function cropFunction = a_crop_image(corner_index)
    function cropped = cropfn(image, factor)
        factor = 1-factor;
        [width, height] = size(image);
        cropw = floor(factor*(width-1))+1;
        croph = floor(factor*(height-1))+1;
        if corner_index == 0
            cropsw = ceil((width-cropw)/2)+1;
            cropsh = ceil((height-croph)/2)+1;
        elseif corner_index == 1
            cropsw = 1;
            cropsh = 1;
        elseif corner_index == 2
            cropsw = width-cropw;
            cropsh = 1;
        elseif corner_index == 3
            cropsw = width-cropw;
            cropsh = height-croph;
        else
            cropsw = 1;
            cropsh = height-croph;
        end
        cropped = imresize(imcrop(image, [cropsw, cropsh, cropw, croph]), [height, width]);
    end
    cropFunction = @cropfn;
end

