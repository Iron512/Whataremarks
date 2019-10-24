function img = dwtsvd(original, mark)
    
    %first part (image splitting)
    [LL,LH,HL,HH] = dwt2(original,'haar');
    
    [ULH,SLH,VLH] = svd(LH);
    [UHL,SHL,VHL] = svd(HL);
    
    %second part (watermark processing)
    mark = bitmark2gs(mark);
    mark = mark(:)';
    
    %[WL,WH] = dwt(mark,'haar');
    WL = double(mark(1,1:256));
    WH = double(mark(1,257:512));
    
    %third part, watermark embedding
    WSHL = zeros(256,'double');
    WSLH = zeros(256,'double');
    
    a = 12;
    for i=(1:256)
        WSHL(i,i) = SHL(i,i) + a*(WL(i));
        WSLH(i,i) = SLH(i,i) + a*WH(i);
    end
        
    WLH = ULH*WSLH*VLH';
    WHL = UHL*WSHL*VHL';
    
img = uint8(idwt2(LL,WLH,WHL,HH,'haar'));