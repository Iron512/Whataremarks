function [img, inputs] = a_awgn(image, factor)
    seed = round(factor*1000);
    img = test_awgn(uint8(image), factor, seed);
    inputs = [factor, seed];       
end


