function [sim_e,max_sim] = ComputeWatermarkSimilarityThreshold(oimg,wimg,aimg)
    
    oimg = imread(oimg);
    wimg = imread(wimg);
    aimg = imread(aimg);

    result_wpsnr = WPSNR(wimg,aimg);

    arnold_strength = 200;
    alpha = 32;

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
    Wembedded = (Sww-S)/alpha;
    Swa = (U'*HH4a*V);
    Wattacked = (Swa-S)/alpha;
    
    %We = iarnold(We,arnold_strength);
    
    sim_e = Wembedded(:)' * Wattacked(:)/sqrt(Wattacked(:)' * Wattacked(:));
    %sim2 = infl_extr_wtrm * infl_extr_wtrm'/sqrt(infl_extr_wtrm * infl_extr_wtrm');
    
    %fprintf("Sim -> %5.5f\nSim with same -> %5.5f", sim,sim2);
    
    max_sim = 0;
    vector_watermark_embedded = Wembedded(:);
    vector_watermark_embedded = vector_watermark_embedded';
    for i = (2:2000)
        random_watermark = randi([0,1],32,32);
        vector_random_watermark = random_watermark(:);
        vector_random_watermark = vector_random_watermark';
        sim = vector_watermark_embedded * vector_random_watermark'/sqrt(vector_random_watermark * vector_random_watermark');
        
        if(max_sim < sim)
           max_sim = sim;
        end
        
        fprintf("sim: %f max sim detected: %f \n",sim,max_sim);
    end
end
 