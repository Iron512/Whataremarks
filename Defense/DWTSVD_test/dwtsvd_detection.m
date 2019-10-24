function [result, result_wpsnr] = dwtsvd_detection(original, watermarked, attacked)
%function result = dwtsvd_detection(original, watermarked, attacked)
    
    orgn = imread(original);
    wtrm = imread(watermarked);
    atck = imread(attacked);

    result_wpsnr = WPSNR(wtrm,atck);

    [~,OLH,OHL,~] = dwt2(orgn,'haar');
    [~,WLH,WHL,~] = dwt2(wtrm,'haar');
    [~,ALH,AHL,~] = dwt2(atck,'haar');

    [UOL,SOL,VOL] = svd(OLH);
    
    [UOH,SOH,VOH] = svd(OHL);
    
    SplusWL = UOH' * WHL * VOH;
    SplusWH = UOL' * WLH * VOL;
    
    SplusAL = UOH' * AHL * VOH;
    SplusAH = UOL' * ALH * VOL;
 
    a = 12;
    wtrm_1 = zeros(256,1,'double');
    wtrm_2 = zeros(256,1,'double');
    
    atck_1 = zeros(256,1,'double');
    atck_2 = zeros(256,1,'double');
    
    %watermark and attacked watermark extraction
    for i=(1:256)
        wtrm_1(i) = ((SplusWL(i,i)-SOH(i,i))/a);     
        wtrm_2(i) = ((SplusWH(i,i)-SOL(i,i))/a);

        atck_1(i) = ((SplusAL(i,i)-SOH(i,i))/a);     
        atck_2(i) = ((SplusAH(i,i)-SOL(i,i))/a);

                
        %wtrm_1 cleaning
        if wtrm_1(i) <= 0.5
            wtrm_1(i) = 0;
        else 
            if wtrm_1(i) > 0.5 && wtrm_1(i) <= 1.5
                wtrm_1(i) = 1;
            else 
                if wtrm_1(i) > 1.5 && wtrm_1(i) <= 2.5
                    wtrm_1(i) = 2;
                else 
                    if wtrm_1(i) > 2.5 && wtrm_1(i) <= 3.5
                        wtrm_1(i) = 3;
                    end
                end
            end
        end
        
        %wtrm_2 cleaning
        if wtrm_2(i) <= 0.5
            wtrm_2(i) = 0;
        else 
            if wtrm_2(i) > 0.5 && wtrm_2(i) <= 1.5
                wtrm_2(i) = 1;
            else 
                if wtrm_2(i) > 1.5 && wtrm_2(i) <= 2.5
                    wtrm_2(i) = 2;
                else 
                    if wtrm_2(i) > 2.5 && wtrm_2(i) <= 3.5
                        wtrm_2(i) = 3;
                    end
                end
            end
        end
        
        %atck_1 cleaning
        if atck_1(i) <= 0.5
            atck_1(i) = 0;
        else 
            if atck_1(i) > 0.5 && atck_1(i) <= 1.5
                atck_1(i) = 1;
            else 
                if atck_1(i) > 1.5 && atck_1(i) <= 2.5
                    atck_1(i) = 2;
                else 
                    if atck_1(i) > 2.5 && atck_1(i) <= 3.5
                        atck_1(i) = 3;
                    end
                end
            end
        end
        
        %atck_2 cleaning
        if atck_2(i) <= 0.5
            atck_2(i) = 0;
        else 
            if atck_2(i) > 0.5 && atck_2(i) <= 1.5
                atck_2(i) = 1;
            else 
                if atck_2(i) > 1.5 && atck_2(i) <= 2.5
                    atck_2(i) = 2;
                else 
                    if atck_2(i) > 2.5 && atck_2(i) <= 3.5
                        atck_2(i) = 3;
                    end
                end
            end
        end
    end
    
    %watermark composition
    extr_wtrm = [wtrm_1;wtrm_2];
    extr_wtrm = extr_wtrm';
    
    atck_wtrm = [atck_1;atck_2];
    atck_wtrm = atck_wtrm';
    
    %watermark inflation
    infl_extr_wtrm = zeros(1,1024);
    infl_atck_wtrm = zeros(1,1024);
    
    for i=(0:2:511)
        infl_extr_wtrm(i*2+1) = extr_wtrm(i+1)/2;
        infl_extr_wtrm(i*2+2) = mod(extr_wtrm(i+1),2);
        
        infl_atck_wtrm(i*2+1) = atck_wtrm(i+1)/2;
        infl_atck_wtrm(i*2+2) = mod(atck_wtrm(i+1),2);
    end
    
    sim = infl_extr_wtrm * infl_atck_wtrm'/sqrt(infl_atck_wtrm * infl_atck_wtrm');
    %sim2 = infl_extr_wtrm * infl_extr_wtrm'/sqrt(infl_extr_wtrm * infl_extr_wtrm');
    
    %fprintf("Sim -> %5.5f\nSim with same -> %5.5f", sim,sim2);
    
    threshold = 13;
    if sim > threshold
        result = 1;
    else
        result = 0;
    end