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
    
    [L,U_orgn] = lu(ABS_orgn);
    [~,U_wtrm] = lu(ABS_wtrm);
    [~,U_atck] = lu(ABS_atck);
    
    a = 10;
    b = 4;
    
    wtrm1 = (U_wtrm(1:16,16:79) - U_orgn(1:16,16:79))/a;
    atck1 = (U_atck(1:16,16:79) - U_orgn(1:16,16:79))/a;
    
    wtrm2 = (U_wtrm(12:43,81:112) - U_orgn(12:43,81:112))/b;
    atck2 = (U_atck(12:43,81:112) - U_orgn(12:43,81:112))/b;

    w1 = wtrm1(:)';
    a1 = atck1(:)';
   
    w2 = wtrm2(:)';
    a2 = atck2(:)';
    
    sim1 = (w1 * a1')/sqrt(a1 * a1');
    sim2 = (w1 * w1')/sqrt(w1 * w1');
    
    sim3 = (w2 * a2')/sqrt(a2 * a2');
    sim4 = (w2 * w2')/sqrt(w2 * w2');
    
    %fprintf("dirty sim1 -> %5.5f \ndirty sim1 with self -> %5.5f\n",sim1,sim2);
    %fprintf("dirty sim2 -> %5.5f \ndirty sim2 with self -> %5.5f\n",sim3,sim4);
    
    if (sim1+sim3) > 30 
        result = 1;
    else
        result = 0;
    end