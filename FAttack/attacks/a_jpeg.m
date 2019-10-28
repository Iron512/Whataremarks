function outputImage = a_jpeg(image,factor)
[row, coln]= size(image);
outputImage = zeros(row, coln);
quality = (1-factor)*100;

Q50 = [ 16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
 
 Q50 = Q50-1;
 
 if quality > 50
     QX = Q50.*(ones(8)*((100-quality)/50));
     QX = uint8(QX);
 elseif quality < 50
     QX = Q50.*(ones(8)*(50/quality));
     QX = uint8(QX);
 elseif quality == 50
     QX = Q50;
 end
 
 QX = round(QX+1);
QX = double(QX);


for i1=[1:8:row]
    for i2=[1:8:coln]
        block=dct2(image(i1:i1+7,i2:i2+7));
        outputImage(i1:i1+7,i2:i2+7)=idct2(round(block./QX).*QX);
    end
end
end

