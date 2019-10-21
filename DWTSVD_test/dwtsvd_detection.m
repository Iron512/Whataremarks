function [result, result_wpsnr] = dwtsvd_detection(original, watermarked, attacked)

orgn = imread(original);
wtrm = imread(watermarked);
atck = imread(attacked);

[~,~,OHL,~] = dwt2(orgn,'haar');
[~,~,WHL,~] = dwt2(wtrm,'haar');
[~,~,AHL,~] = dwt2(atck,'haar');

[~,OS,~] = svd(OHL);
[~,WS,~] = svd(WHL);
[~,AS,~] = svd(AHL);

extr_wtrm = WS - OS;
%atck_wtrm = AS - OS;



result = 0;
result_wpsnr = 0;