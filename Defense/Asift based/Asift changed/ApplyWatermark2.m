function f = ApplyWatermark2(img,watermarking)
    % implementation of the algotithm described in this paper https://res.mdpi.com/d_attachment/applsci/applsci-08-00410/article_deploy/applsci-08-00410-v2.pdf
  
    arnold_strength= 40;
    strength = 0.5;
    
    [LL1,LH1,HL1,HH1] = dwt2(img,'Haar');
    [LL2,LH2,HL2,HH2] = dwt2(LL1,'Haar');
    [LL3,LH3,HL3,HH3] = dwt2(LL2,'Haar');
    [LL4,LH4,HL4,HH4] = dwt2(LL3,'Haar');
    
    [U,S,V] = svd(HH4);
    
    W = watermarking; 
    
    %W = arnold(watermarking,arnold_strength);
    
    SW = S .*(1 + W* strength);
    
    [Uw,Sww,Vw] = svd(SW);
    
    HH4w = U*SW*V';
    
    LL3w = idwt2(LL4,LH4,HL4,HH4w,'Haar');
    LL2w = idwt2(LL3w,LH3,HL3,HH3,'Haar');
    LL1w = idwt2(LL2w,LH2,HL2,HH2,'Haar');
    imgw = idwt2(LL1w,LH1,HL1,HH1,'Haar');
    
    f = uint8(imgw);
end


