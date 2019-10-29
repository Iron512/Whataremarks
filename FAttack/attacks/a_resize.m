function [img, inputs] = a_resize(image, factor)
    factor=1-sqrt(factor);
    img = test_resize(image, factor);
    inputs = [factor];
end


