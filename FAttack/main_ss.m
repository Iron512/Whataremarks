alpha = 0.1;
watermark = uint8(randi([0,1],32,32));
embed = ss_embed(alpha);
detect = ss_detect(0, alpha, 1024);

originalImage = "lena_gs.png";
watermarkedImage = "wtma.bmp";

im = imread(originalImage);

watermarked = embed(originalImage, watermark);
imwrite(watermarked, watermarkedImage);

[res, wps, sim] = detect(originalImage, watermarkedImage, watermarkedImage);
isim = sim;
msim = 0;
for i=1:20
   fw =  embed(originalImage,  uint8(randi([0,1],32,32)));
   [res, wps, sim] = detect(originalImage, watermarkedImage, qsave(fw));
   if sim > msim
       msim = sim;
   end
end

threshold = msim.*0.9+isim.*0.1;
detect = ss_detect(threshold, alpha, 1024);


[attackedImage, wpsn, attack, factor, points] = test_algorithm(originalImage,watermarkedImage, detect);



