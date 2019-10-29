function aFn = a_sharpen(direction)

function [img, inputs] = shFn(image, factor)
    if mod(direction, 2) > 0 
        w = 70.*factor;
    else
        w = 1;
    end
    if (direction > 1)
        h = 70.*factor;
    else
        h = 1;
    end
    img = test_sharpening(image, w, h);
    inputs = [w, h];
end
aFn = @shFn;

end

