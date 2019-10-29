
function Iatt = test_jpeg(Iw, QF, fn)

imwrite(Iw, fn, 'Quality', QF);
Iatt = imread(fn);
delete(fn);




