function [quality_factor, wpsnr_out] = equalization2(original_image_string, watermarked_image_string)

original_image = imread(original_image_string);
watermarked_image = imread(watermarked_image_string);
parameter = 1000;

attacked_image = test_equalization(watermarked_image,parameter);
imwrite(attacked_image, 'attacked_image.bmp','bmp');
[presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
if (presence == 0) 
    "OK equalization"
    parameter = 10;
    attacked_image = test_equalization(watermarked_image,parameter);
    imwrite(attacked_image, 'attacked_image.bmp','bmp');
    [presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
    while (presence == 1)
        parameter = parameter + 50;
        attacked_image = test_equalization(watermarked_image,parameter);
        imwrite(attacked_image, 'attacked_image.bmp','bmp');
        [presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
    end
    %if presence == 0
        quality_factor = parameter;
        wpsnr_out = wpsnr;
    %end
else
        "equalization non rompe"
        quality_factor=0;
        wpsnr_out=0;
    end    
end