img = imread("lena.bmp");
w = load("whataremarks.mat");
w = w.w;

imgw = ApplyWatermark(img,w);

imwrite(imgw,"watermarked_lena.bmp");

figure(1);imshow(img);title('original image');
figure(2);imshow(imgw);title('restored image from the watermarked img');

%[sim_e,max_sim] = ComputeWatermarkSimilarityThreshold("lena.bmp","watermarked_lena.bmp","watermarked_lena.bmp");
%fprintf('sim: %f max_sim = %f' , sim_e,max_sim);

[result,wpsnr] = WatermarkDetection("lena.bmp","watermarked_lena.bmp","watermarked_lena.bmp");
fprintf("watermarked: %f wpsnr: %f",result,wpsnr);
