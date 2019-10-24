orgn = imread('lena_gs.png');
mark = load('whataremarks.mat');
mark = mark.w;

watermarked = dwtsvd(orgn,mark);
imwrite(watermarked,'watermarked.png')

values = zeros(1,100);
%values(1) = dwtsvd_detection('lena_gs.png','watermarked.png','watermarked.png');
max = 0;

for i=(2:1000)
    rndw = randi([0,1],32,32);
    
    randomMarked = dwtsvd(orgn,rndw);
    imwrite(randomMarked,'random.png');
    
    fprintf(" %f\n", i);
    x =  dwtsvd_detection('lena_gs.png','watermarked.png','random.png');
    values(i) = x;
    if x > max 
        max = x;
    end
end
fprintf("ended the treshold computation\nresults are:\nsim -> %5.5f\nmax -> %5.5f",values(1), max);