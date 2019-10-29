function binaryFn = binary_function(attackAlgo, originalImage, watermarkedImage, detectFunction)
    wImg = imread(watermarkedImage);
    function [res, out, attackedImage] = try_attack(factor, varargin)
        attackedImage = uint8(attackAlgo(wImg, factor));
        [res, out] = detectFunction(originalImage, watermarkedImage,  qsave(attackedImage));
        %fprintf("Binary %.2f -> %d - %.2f\n", factor, res, out);
        if (res == 0)
            res = -1;
        end 
    end
binaryFn = @try_attack;
end

