function [attackedImage, wpsn, attack, factor, points] = test_algorithm(originalImage,watermarkedImage, detectFunction)
[attackedImage, wpsn, attack, factor] = main_attack(originalImage,watermarkedImage, detectFunction);
im = imread(originalImage);
watermarked = imread(watermarkedImage);
dwps = WPSNR(im, watermarked);

fprintf("----------------------------------------------------------------------------\nFINAL RESULT:\nBest attack:\n");
ima = watermarked;
for i=1:length(attack)
   a = attack{i};
   [ima, inputs] = a(ima, factor(i));
   fprintf("%s(", strrep(char(a), "a_", "test_")); 
   print_vector(inputs);
   fprintf(");\n");
end
fprintf("ATTACK WPSNR: %.3f\nDEFENSE WPSNR: %.3f\n", wpsn, dwps);


if dwps >= 66
    dpts = 6;
elseif dwps >= 62
    dpts = 5;
elseif dwps >= 58
    dpts = 4;
elseif dwps >= 54
    dpts = 3;
elseif dwps >= 50
    dpts = 2;
elseif dwps >= 35
    dpts = 1;
else
    dpts = 0;
end

if wpsn >= 53
    rpts = 0;
elseif wpsn >= 50
    rpts = 1;
elseif wpsn >= 47
    rpts = 2;
elseif wpsn >= 44
    rpts = 3;
elseif wpsn >= 41
    rpts = 4;
elseif wpsn >= 38
    rpts = 5;
else
    rpts = 6;
end
points = dpts+rpts;
fprintf("Total competition points: %d (%d quality, %d robustness)\n", points, dpts, rpts);
imwrite(attackedImage, "attackedImage.bmp");
fprintf("Attacked image saved to attackedImage.bmp\n");

[res, wps] = detectFunction(originalImage, watermarkedImage, "attackedImage.bmp");
if res == 1
    printf("Im trolling clearly, dont trust whatever I just said :(\n");
end


imshow([im, watermarked, attackedImage]);
end

