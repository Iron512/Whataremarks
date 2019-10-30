img = imread("lena.bmp");
w = load("whataremarks.mat");
w = w.w;

imgw = ApplyWatermark2(img,w);

imwrite(imgw,"watermarked_lena2.bmp");

figure(1);imshow(img);title('original image');
figure(2);imshow(imgw);title('restored image from dct');

[sim_e,max_sim] = ComputeWatermarkSimilarityThreshold2('lena.bmp',"watermarked_lena2.bmp","watermarked_lena2.bmp");
fprintf("Sim: %f, max random sim: %f" , sim_e,max_sim);

%[result,wpsnr] = WatermarkDetection("lena.bmp","watermarked_lena.bmp","watermarked_lena.bmp");

%fprintf("watermarked: %f wpsnr: %f",result,wpsnr);
