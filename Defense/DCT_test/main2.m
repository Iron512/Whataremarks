function im = main2(image, mark)
mark = double(mark);
orgn = imread(image);


%mark = randi([0,1],32,32);

coeff_matrix = dct2(double(orgn));


[L,U,P] = lu(coeff_matrix);
a = 15;


[dimx,dimy] = size(U);
        
It_re = reshape(U,1,dimx*dimy);
[~,Ix] = sort(abs(It_re),'descend');
newU = It_re;

k = 50;
for j = 1:length(mark)
    m = Ix(k);
    newU(m) = It_re(m)+a*mark(j);
    k = k+1;
end


newU=reshape(newU,dimx,dimy);


result = P\L*newU;
result = idct2(result);
wp = WPSNR(orgn, result);

%imshow(uint8(result));
fprintf("wpsnr -> %5.5f\n",wp);
%imwrite(uint8(result),"attacked_44.bmp");
im = result;
end