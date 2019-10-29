function [result, result_wpsnr, sim] = dwtlu_det(original, watermarked, attacked)
%function result = dwtsvd_detection(original, watermarked, attacked)
    orgn = imread(original);
    wtrm = imread(watermarked);
    atck = imread(attacked);

    result_wpsnr = WPSNR(wtrm,atck);

    [~,OLH,~,~] = dwt2(orgn,'haar');
    [~,WLH,~,~] = dwt2(wtrm,'haar');
    [~,ALH,~,~] = dwt2(atck,'haar');

   
  
    
    ew = zeros(1, 1024);
    ewa = zeros(1, 1024);
    
    a = 40;
    k=0;
    for i=1:32
        for j=1:32
            k=k+1;
            if (k > 1024)
                break;
            end
            
            ew(k) = (WLH(i*7, j*7)-OLH(i*7,j*7))/a;
             ew(k) = (ew(k) +(WLH(i*7+1, j*7+1)-OLH(i*7+1,j*7+1))/a)/2;
            ewa(k) = (ALH(i*7, j*7)-OLH(i*7,j*7))/a;
            ewa(k) = (ewa(k)+(ALH(i*7+1, j*7+1)-OLH(i*7+1,j*7+1))/a)/2;
        end
        
    end
  
    sim = (ew*(ewa'))/sqrt(ewa*ewa');
    
    threshold = 14;
    if sim > threshold
        result = 1;
    else
        result = 0;
    end