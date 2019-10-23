function [quality_factor, wpsnr_out] = awgn2(original_image_string, watermarked_image_string)

original_image = imread(original_image_string);
watermarked_image = imread(watermarked_image_string);
parameter = 0.05;

attacked_image = test_awgn(watermarked_image,parameter,4);
imwrite(attacked_image, 'attacked_image.bmp','bmp');
[presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
if (presence == 0) 
    "OK awgn"
    parameter = 0.001;
    attacked_image = test_awgn(watermarked_image,parameter,4);
    imwrite(attacked_image, 'attacked_image.bmp','bmp');
    [presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
    while (presence == 1)
        parameter = parameter + 0.005;
        attacked_image = test_awgn(watermarked_image,parameter,4);
        imwrite(attacked_image, 'attacked_image.bmp','bmp');
        [presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
    end
    %if presence == 0
        quality_factor = parameter;
        wpsnr_out = wpsnr;
    %end
else
    "awgn non rompe"
    quality_factor=0;
    wpsnr_out=0;
end  
end