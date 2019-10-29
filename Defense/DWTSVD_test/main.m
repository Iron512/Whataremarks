orgn = imread('lena_gs.png');
mark = load('whataremarks.mat');
mark = mark.w;
rndm = imread('randomWatermark.png');

wtrm = dwtsvd(orgn, mark);
rndw = dwtsvd(orgn, rndm/255);

subplot(1,3,1)
imshow(orgn);

subplot(1,3,2)
imshow(wtrm);

subplot(1,3,3)
imshow(rndw);

wpsnrOrig = WPSNR(orgn,wtrm);
wpsnrRndw = WPSNR(wtrm,rndw);

fprintf("\nWPSNR -> %5.5f\nWPSNR with random -> %5.5f", wpsnrOrig,wpsnrRndw)
imwrite(wtrm,'watermarked_lena.png');
imwrite(rndw,'randomwatermarked_lena.png');