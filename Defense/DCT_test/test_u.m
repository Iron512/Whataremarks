im = imread("lena_gs.png");

[L, U, P] = lu(dct2(double(im)));
U2 = zeros(512);

for i=1:512
    for j=i:512
        U2(i,j)=U(i,j)+1;
    end
end



im2 = uint8(idct2(P\L*U2));
im2 = test_jpeg(im2, 50, "test.jpg");

[L2, U3, P3] = lu(dct2(double(im2)));

de = (U3-U2);