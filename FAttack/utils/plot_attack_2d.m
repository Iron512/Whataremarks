function f = plot_attack_2d(attackFunction, detect, original, watermarked)
    wImg = imread(watermarked);
    function [wps, res] = ff(x)
        attackedImage = attackFunction(wImg, x);
        [res, wps, ~] = detect(original, watermarked, qsave(attackedImage));
        fprintf("X: %f, W: %f\n", x, wps);
        %disp(wps);
        res = res*50;
    end
    f = @ff;
end

