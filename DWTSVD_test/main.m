orgn = imread('lena_gs.png');
wtrm = dwtsvd('lena_gs.png', 'watermark.png');

subplot(1,2,1)
imshow(orgn);

subplot(1,2,2)
imshow(wtrm);

wps = WPSNR(orgn,wtrm);
fprintf("\nWPSNR -> %5.5f", wps)
imwrite(wtrm,'./DWTSVD_test/watermarked_lena.png');
