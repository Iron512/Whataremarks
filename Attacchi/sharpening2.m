function [quality_factor, wpsnr_out] = sharpening2(original_image_string, watermarked_image_string)

original_image = imread(original_image_string);
watermarked_image = imread(watermarked_image_string);
parameter = 1.5;
radius = 2;

attacked_image = test_sharpening(watermarked_image,radius,parameter);
imwrite(attacked_image, 'attacked_image.bmp','bmp');
[presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
if (presence == 0) 
    "OK sharpening"
    parameter = 0.1;
    attacked_image = test_sharpening(watermarked_image,radius,parameter);
    imwrite(attacked_image, 'attacked_image.bmp','bmp');
    [presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
    while (presence == 1)
        parameter = parameter + 0.1;
        attacked_image = test_sharpening(watermarked_image,radius,parameter);
        imwrite(attacked_image, 'attacked_image.bmp','bmp');
        [presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
    end
    %%if presence == 0
        quality_factor = parameter;
        wpsnr_out = wpsnr;
    %%end
else
    "sharpening non rompe"
    quality_factor=0;
    wpsnr_out=0;
end 

end