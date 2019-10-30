function [result,result_wpsnr] = WatermarkDetection2(oimg,wimg,aimg)
    
    oimg = imread(oimg);
    wimg = imread(wimg);
    aimg = imread(aimg);

    result_wpsnr = WPSNR(wimg,aimg);

    arnold_strength = 200;
    alpha = 0.8;

    [LL1,LH1,HL1,HH1] = dwt2(oimg,'Haar');
    [LL2,LH2,HL2,HH2] = dwt2(LL1,'Haar');
    [LL3,LH3,HL3,HH3] = dwt2(LL2,'Haar');
    [LL4,LH4,HL4,HH4] = dwt2(LL3,'Haar');

    [LL1w,LH1w,HL1w,HH1w] = dwt2(wimg,'Haar');
    [LL2w,LH2w,HL2w,HH2w] = dwt2(LL1w,'Haar');
    [LL3w,LH3w,HL3w,HH3w] = dwt2(LL2w,'Haar');
    [LL4w,LH4w,HL4w,HH4w] = dwt2(LL3w,'Haar');
    
    [LL1a,LH1a,HL1a,HH1a] = dwt2(aimg,'Haar');
    [LL2a,LH2a,HL2a,HH2a] = dwt2(LL1a,'Haar');
    [LL3a,LH3a,HL3a,HH3a] = dwt2(LL2a,'Haar');
    [LL4a,LH4a,HL4a,HH4a] = dwt2(LL3a,'Haar');
    
    
    [U,S,V] = svd(HH4);
    
    Sww = (U'*HH4w*V);
    Wembedded = (Sww-S)/(alpha*S);
    Swa = (U'*HH4a*V);
    Wattacked = (Swa-S)/(alpha*S);
    
    %We = iarnold(We,arnold_strength);
    
    sim_e = Wembedded(:)' * Wattacked(:)/sqrt(Wattacked(:)' * Wattacked(:));
    %sim2 = infl_extr_wtrm * infl_extr_wtrm'/sqrt(infl_extr_wtrm * infl_extr_wtrm');
    
    %fprintf("Sim -> %5.5f\nSim with same -> %5.5f", sim,sim2);
    
    result = 0;
    
    if(sim_e>1.9)
        result = 1;
    else 
        result = 0;
    end
    
    
end