function detect_function = lsr_detect(threshold, bit)
    function [result, wpsnr, sim] = detect_fn(~, watermarkedImage, attackedImage)
        watermarkedImage = imread(watermarkedImage);
        attackedImage = imread(attackedImage);
        watermarkFromWatermarked = bitget(watermarkedImage, bit);
        watermarkFromAttacked = bitget(attackedImage, bit);
        w = double(watermarkFromWatermarked(:)');
        w_rec = double(watermarkFromAttacked(:)');  
        sim = w * w_rec' / sqrt( w_rec * w_rec' );
        if sim>threshold  
            result = 1;
        else
            result = 0;
        end
        wpsnr = WPSNR(watermarkedImage, attackedImage);
        
    end
    detect_function = @detect_fn;
end
