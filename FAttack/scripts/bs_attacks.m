function [ress_f, values_f, wpsns_f, imgs_f, attacks_f]  = bs_attacks(attackList, originalImage, watermarkedImage, detectFunction, precision, keepAttacks)
alen = length(attackList);
ress = zeros(1, alen);
values = cell(1, alen);
wpsns = zeros(1, alen);
imgs = cell(1, alen);
keepAttacks = min(alen, keepAttacks);
mf = 0.75;
minwps = 0;
    for i=1:alen
        [wpss, ~] = sort(wpsns, 'descend');
        bf = binary_function(attackList{i}, originalImage, watermarkedImage, detectFunction);
        [res, value, wps, img] = binary_search(bf, 0, 1, precision, min(wpss(keepAttacks), minwps), 0, [], 1); 
        if res ~= -2
        fprintf('-best wpsnr with %s attack: %.2f - factor: %.3f\n', char(attackList{i}), wps, value(1));
        if (mf*wps) > minwps
            minwps = mf*wps;
        end
        else
        fprintf("-skipping full binary search for attack %s: watermark detected with low (%.2f) wpsnr\n", char(attackList{i}), wps);
        end
        ress(i) = res;
        values{i} = value;
        wpsns(i) = wps;
        imgs{i} = img;
    end
    keepAttacks = max(keepAttacks, sum(wpsns > minwps));
    [wpss, oind] = sort(wpsns, 'descend');
ress_f = zeros(1, keepAttacks);
values_f = cell(1, keepAttacks);
wpsns_f = zeros(1, keepAttacks);
imgs_f = cell(1, keepAttacks);  
attacks_f = cell(1, keepAttacks);  
for i=1:keepAttacks
    wpsns_f(i) = wpss(i);
    index = oind(i);
    values_f{i} = values{index};
    ress_f(i) = ress(index);
    imgs_f{i} = imgs{index};
    attacks_f{i} = attackList{index};
end

end

