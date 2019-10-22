function [quality_factor, wpsnr_out] = median2(original_image_string, watermarked_image_string)

original_image = imread(original_image_string);
watermarked_image = imread(watermarked_image_string);
parameter1 = 10;
parameter2 = 10;

attacked_image = test_median(watermarked_image,parameter1,parameter2);
imwrite(attacked_image, 'attacked_image.bmp','bmp');
[presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
wpsnr_out = 0;
if (presence == 0) 
    "OK median"
    for parameter1 = 1:10
        for parameter2 = 2:10
          attacked_image = test_median(watermarked_image,parameter1,parameter2);
          imwrite(attacked_image, 'attacked_image.bmp','bmp');
          [presence,wpsnr] = detection_robercolor(original_image_string,watermarked_image_string,'attacked_image.bmp');
          if (presence == 0 && wpsnr > wpsnr_out)
              out1 = parameter1;
              out2 = parameter2;
              wpsnr_out = wpsnr;
          end
        end
    end
    
    %if presence == 0
        quality_factor = [out1,out2];
    %end
else
     "median non rompe"
     quality_factor=0;
end    
end