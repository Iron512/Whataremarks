function [img, inputs] = a_jpeg(image,factor)
quality = (1-factor)*100;
inputs = [quality];
fn = ['jp', num2str(floor(now*100000000000-floor(now*100)*1000000000)), num2str(sum(image(:))), num2str(round(quality.*100)), num2str(randi(10000000)), '.jpg'];
img = test_jpeg(uint8(image), quality, fn);

end

