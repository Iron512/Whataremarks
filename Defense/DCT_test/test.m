watermark = uint8(randi([0,1],32,32));
embed = @dwtlu;
detect = @dwtlu_det;

originalImage = "lena_gs.png";
watermarkedImage = "wtma2.bmp";

im = imread(originalImage);

watermarked = embed(originalImage, watermark);

imwrite(uint8(watermarked), watermarkedImage);

[res, wps, sim] = detect(originalImage, watermarkedImage, watermarkedImage);
isim = sim;
disp(isim);
msim = 0;
for i=1:20
   fw =  embed(originalImage,  uint8(randi([0,1],32,32)));
   [res, wps, sim] = detect(originalImage, watermarkedImage, qsave(fw));
   disp(sim);
   if sim > msim
       msim = sim;
   end
end

threshold = msim.*0.9+isim.*0.1;
detect = ss_detect(threshold, alpha, 1024);