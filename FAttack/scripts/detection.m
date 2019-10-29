function [result,wpsnr] = detection(original, watermarked, attacked)
    orgn = imread(original);
    wtrm = imread(watermarked);
    atck = imread(attacked);
    %w = load('whataremarks.mat');
    %w = w.w;
    
    wpsnr = WPSNR(wtrm, atck);

    d_orgn = dct2(double(orgn));
    d_wtrm = dct2(double(wtrm));
    d_atck = dct2(double(atck));
    
    ABS_orgn = abs(d_orgn);
    ABS_wtrm = abs(d_wtrm);
    ABS_atck = abs(d_atck);
    
    [~,U_orgn] = lu(ABS_orgn);
    [~,U_wtrm] = lu(ABS_wtrm);
    [~,U_atck] = lu(ABS_atck);
    
    a = 14;
    wtrm = (U_wtrm(1:32,33:64) - U_orgn(1:32,33:64))/a;
    atck = (U_atck(1:32,33:64) - U_orgn(1:32,33:64))/a;
                
    w = wtrm(:)';
    a = atck(:)';
   
    sim1 = (w * a')/sqrt(a * a');
    %sim2 = (w * w')/sqrt(w * w');

    fprintf("dirty sim -> %5.5f \ndirty sim with self -> %5.5f\n",sim1,sim2);

    if sim1 > 14 
        result = 1;
    else
        result = 0;
    end