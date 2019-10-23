function img = dwtsvd(original, mark)
    
    %first part (image splitting)
    [LL,LH,HL,HH] = dwt2(original,'haar');
    
    [ULH,SLH,VLH] = svd(LH);
    [UHL,SHL,VHL] = svd(HL);
    
    %second part (watermark processing)
    mark = bitmark2gs(mark);
    mark = mark(:)';
    
    [WL,WH] = dwt(mark,'haar');
    
    %third part, watermark embedding
    a = 30;
    for i=(1:256)
        SHL(i,i) = SHL(i,i) + a*WL(i);
        SLH(i,i) = SLH(i,i) + a*WH(i);
    end
        
    LH = ULH*SLH*VLH';
    HL = UHL*SHL*VHL';
    
img = uint8(idwt2(LL,LH,HL,HH,'haar'));