function detect_function = ss_detect(threshold, alpha, wsize)
    function [result, wpsnr, sim] = detect_fn(originalImage, watermarkedImage, attackedImage)
        watermarkedImage = imread(watermarkedImage);
        originalImage = imread(originalImage);
        attackedImage = imread(attackedImage);
        [dimx,dimy] = size(originalImage);
        It = dct2(double(originalImage));
        It_re = reshape(It,1,dimx*dimy);
        [~,Ix] = sort(abs(It_re),'descend');
        
        Itw = dct2(double(watermarkedImage));
        It_rew = reshape(Itw,1,dimx*dimy);
        
        Ita = dct2(double(attackedImage));
        It_rea = reshape(Ita,1,dimx*dimy);
        
        ew = zeros(1, wsize);
        ewa = zeros(1, wsize);
        
        k = 2;
        for j = 1:wsize
            m = Ix(k);
            ew(j) = max(min(round((It_rew(m)/It_re(m)-1)/alpha), 1),0);
            ewa(j) = max(min(round((It_rea(m)/It_re(m)-1)/alpha), 1),0);           
            k = k+1;
        end
        sim = (ew*(ewa'))/sqrt(ewa*ewa');
        if isnan(sim)
            sim = 0;
        end
        
        if sim > threshold
            result = 1;
        else
            result = 0;
        end
        
        wpsnr = WPSNR(attackedImage, watermarkedImage); 
    end
    detect_function = @detect_fn;
end