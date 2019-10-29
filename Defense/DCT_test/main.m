orgn = imread('lena_gs.png');
mark = load('whataremarks.mat');
mark = mark.w;
%mark = randi([0,1],32,32);

coeff_matrix = dct2(double(orgn));

ABS = abs(coeff_matrix);
SGN = sign(coeff_matrix);

[L,U] = lu(ABS);
a = 14;

U(1:32,33:64) = U(1:32,33:64) + a*mark; 

result = (L*U).*SGN;
result = idct2(result);
wp = WPSNR(orgn, result);

imshow(uint8(result));
fprintf("wpsnr -> %5.5f",wp);
%imwrite(uint8(result),"attacked_51.bmp");