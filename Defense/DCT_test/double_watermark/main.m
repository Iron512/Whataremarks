orgn = imread('lena_gs.png');
mark = load('whataremarks.mat');
%mark = mark.w;
%mark = randi([0,1],32,32);

coeff_matrix = dct2(double(orgn));

ABS = abs(coeff_matrix);
SGN = sign(coeff_matrix);

first_wtrm = [mark(1:16,:),mark(17:32,:)];

[L,U] = lu(ABS);
a = 10;
b = 4;

U(1:16,16:79) = U(1:16,16:79) + a*first_wtrm;
U(12:43,81:112) = U(12:43,81:112) + b*mark; 

result = (L*U).*SGN;
result = idct2(result);
wp = WPSNR(orgn, result);

imshow(uint8(result));
fprintf("wpsnr -> %5.5f",wp);
%imwrite(uint8(result),"double_attacked_54.bmp");