function funcmin = minimize_function(attackList, originalImage, watermarkedImage, detectFunction)
    attackFunction = multi_attack(attackList);
    wImg = imread(watermarkedImage); 
    function [error, img] = fnoptimize(factors)
        if any(factors > 1) || any(factors < 0)
            error = NaN;
            return;
        end
            
        
        attackedImage = attackFunction(wImg, factors);
        img = attackedImage;
        fn = ['att', num2str(floor(now*100000000000-floor(now*100)*1000000000)), num2str(sum(attackedImage(:))), num2str(randi(10000000)), '.bmp'];
        imwrite(attackedImage, fn);
        [res, wps] = detectFunction(originalImage, watermarkedImage,fn);
        delete(fn);
        if res ~= 0
            error = NaN;
        else
            error = 1/wps;
            %print_vector(factors);
            %fprintf(" -> %4f (%d, %.2f)\n", error, res, wps);
        end
        
    end
    funcmin = @fnoptimize;
end

