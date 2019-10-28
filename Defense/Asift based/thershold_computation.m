orgn = imread('lena.bmp');
mark = load('whataremarks.mat');
mark = mark.w;

watermarked = WatermarkingType1(orgn,mark);
imwrite(watermarked,'watermarked.bmp')

values = zeros(1,100);
%values(1) = dwtsvd_detection('lena_gs.png','watermarked.png','watermarked.png');
max = 0;

for i=(2:1000)
    rndw = randi([0,1],1024);
    
    randomMarked = WatermarkingType1(orgn,rndw);
    imwrite(randomMarked,'random.png');
    
    fprintf(" %f\n", i);
    x =  WatermarkingType1Detection('lena.bmp','watermarked.bmp','random.bmp');
    values(i) = x;
    if x > max 
        max = x;
    end
end
fprintf("ended the treshold computation\nresults are:\nsim -> %5.5f\nmax -> %5.5f",values(1), max);