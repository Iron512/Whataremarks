function [attackFunctions, binaryPrecision, gaTrials] = get_attack_list(detectTime)
attackFunctions = { a_downscale(3), a_medfilter(3), a_downscale(1), a_downscale(2), @a_blur, @a_jpeg2, a_medfilter(1), a_medfilter(2), a_medfilter(3), moderate_attack(@a_histeq), a_crop_image(0), a_awgn(0), a_awgn(1)};
binaryPrecision = 0.001;
gaTrials = [3, 3, 4];
end

