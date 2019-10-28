function attFn = a_awgn(domain)
    function img = aw(image, factor)
        if domain == 0
            dm = image;
        elseif domain == 1
            dm = dct2(image);
        end
        [w, h] = size(dm);
        n = wgn(w, h, factor*100).*factor;
        ndm = dm+n;
        if domain == 0
            img = ndm;
        elseif domain == 1
            img = idct2(ndm);
        end
       
    end
    attFn = @aw;

end

