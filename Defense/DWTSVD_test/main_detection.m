[val,wp] = dwtsvd_detection('lena_gs.png','watermarked_lena.png','watermarked_lena.png');
fprintf("res -> %1.0f, WPSNR -> %5.5f\n",val,wp);