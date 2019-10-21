

function img = dwtsvd(plain, watermark)

    original = imread(plain);
    mark =  imread(watermark);
    
    [LL,LH,HL,HH] = dwt2(original,'haar');
    
    mark_gs = bitmark2gs(mark);
    
    [~,~,WHL,~] = dwt2(mark_gs,'haar');
    
    [U,S,V] = svd(HL);
    [~,WS,~] = svd(WHL);
    
    startx = 1;
    starty = 1;
    [sizeix,sizeiy] = size(S);
    [sizewx,sizewy] = size(WS);
    
    sumMatrixWS = zeros(sizeix,sizeiy);
    sumMatrixWS(startx:startx-1+sizewx,starty:starty-1+sizewy) = WS;
    imwrite(sumMatrixWS,'./DWTSVD_test/obtained.png');
    
    S = S + sumMatrixWS;
    
    HL = U*S*V';
img = uint8(idwt2(LL,LH,HL,HH,'haar'));