originalImage = "lena_gs.png";
watermarkedImage = "watermarked_lena.png";
detectFunction = @dwtsvd_detection;

[attackedImage, wpsn, attack, factor, points] = test_algorithm(originalImage,watermarkedImage, detectFunction);
