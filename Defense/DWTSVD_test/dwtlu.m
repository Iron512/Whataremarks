function img = dwtlu(original, mark)

    original = imread(original);
    
    %first part (image splitting)
    [LL,LH,HL,HH] = dwt2(original,'haar');
    
  
    %[UHL,SHL,VHL] = svd(HL);
    
    %second part (watermark processing)
    %mark = bitmark2gs(mark);
    %mark = mark(:)';
    
    %[WL,WH] = dwt(mark,'haar');
    %WL = double(mark(1,1:256));
    %WH = double(mark(1,257:512));
    
    %third part, watermark embedding
    LHW = LH;
   % WSLH = zeros(256,'double');
    
    a = 40;
    k=0;
    for i=1:32
        for j=1:32
            k=k+1;
            LHW(i*7,j*7) = LH(i*7,j*7) + a*(mark(k));
            LHW(i*7+1,j*7+1) = LH(i*7,j*7+1) + a*(mark(k));
        end
        
    end
    
    
   
        

    
img = uint8(idwt2(LL,LHW,HL,HH,'haar'));
end