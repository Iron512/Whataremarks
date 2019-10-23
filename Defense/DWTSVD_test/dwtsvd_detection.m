%function [result, result_wpsnr] = dwtsvd_detection(original, watermarked, attacked)
function result = dwtsvd_detection(original, watermarked, attacked)
    orgn = imread(original);
    wtrm = imread(watermarked);
    atck = imread(attacked);

    [~,OLH,OHL,~] = dwt2(orgn,'haar');
    [~,WLH,WHL,~] = dwt2(wtrm,'haar');
    [~,ALH,AHL,~] = dwt2(atck,'haar');

    [~,SOL,~] = svd(OLH);
    [~,SWL,~] = svd(WLH);
    [~,SAL,~] = svd(ALH);
    
    [~,SOH,~] = svd(OHL);
    [~,SWH,~] = svd(WHL);
    [~,SAH,~] = svd(AHL);

    extr_wtrmL = zeros(512,1);
    extr_wtrmH = zeros(512,1);
    
    atck_wtrmL = zeros(512,1);
    atck_wtrmH = zeros(512,1);
    
    a = 30;
    for i=(1:256)
        extr_wtrmL(i) = (SWH(i,i) - SOH(i,i))/a; 
        atck_wtrmL(i) = (SAH(i,i) - SOH(i,i))/a;
        
        extr_wtrmH(i) = (SWL(i,i) - SOL(i,i))/a;
        atck_wtrmH(i) = (SAL(i,i) - SOL(i,i))/a;
    end
    
    extr_wtrmL = extr_wtrmL';
    extr_wtrmH = extr_wtrmH';
    
    atck_wtrmL = atck_wtrmL';
    atck_wtrmH = atck_wtrmH';
    
    extr_wtrm = idwt(extr_wtrmL,extr_wtrmH,'haar');
    atck_wtrm = idwt(atck_wtrmL,atck_wtrmH,'haar');
    %atck_wtrm = extr_wtrm;
    
    sim = extr_wtrm * atck_wtrm'/sqrt(atck_wtrm * atck_wtrm');
   
    %sim = extr_wtrm * atck_wtrm' / (sqrt(extr_wtrm*extr_wtrm') * sqrt(atck_wtrm*atck_wtrm'))
    
    %fprintf("Sim -> %5.5f", sim);

    result = sim;
    %result_wpsnr = 0;