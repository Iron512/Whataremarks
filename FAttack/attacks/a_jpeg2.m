function Iatt = a_jpeg2(image, factor)
quality = (1-factor)*100;
fn = ['jp', num2str(floor(now*100000000-floor(now*100)*1000000)),  num2str(round(quality*100)), num2str(sum(image(:))), num2str(randi(10000)), '.jpg'];
imwrite(uint8(image), fn, 'Quality', quality);
Iatt = imread(fn);
delete(fn);

