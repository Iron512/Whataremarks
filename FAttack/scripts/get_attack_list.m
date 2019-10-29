function [attackFunctions, binaryPrecision, gaTrials] = get_attack_list(detectTime)
attackFunctions = {@a_blur, @a_jpeg, a_median(1), a_median(2),a_median(3), @a_resize, a_sharpen(1), a_sharpen(2), a_sharpen(3), @a_histeq, @a_awgn};
binaryPrecision = 0.001;
gaTrials = [2];
end

