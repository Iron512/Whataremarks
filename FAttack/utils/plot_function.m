function f = plot_function(attackFunction, detect, original, watermarked)
    wImg = imread(watermarked);
    function [res, value] = ff(factors)
        attackedImage = attackFunction(wImg, factors);
        [res, wps, ~] = detect(original, watermarked, qsave(attackedImage));
        
        %fprintf('Factors: [');
        %fprintf('%g ', factors);
        %fprintf('] -> %f\n', wps);
        value = wps;
        if value < 25
            res = -1;
        end
    end
    f = @ff;
end