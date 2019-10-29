function [result, wpsnr, sim] = detect2(originalImage, watermarkedImage, attackedImage)
        watermarkedImage = imread(watermarkedImage);
        originalImage = imread(originalImage);
        attackedImage = imread(attackedImage);
        
        [~, It, P] = lu(dct2(double(originalImage)));
        alpha = 15;
        [dimx,dimy] = size(It);
        
        It_re = reshape(It,1,dimx*dimy);
        [~,Ix] = sort(abs(It_re),'descend');
        
        [~, Itw, Pw] = lu(dct2(double(watermarkedImage)));
        It_rew = reshape(Itw,1,dimx*dimy);
        
        [~, Ita, Pa] = lu(dct2(double(attackedImage)));
        It_rea = reshape(Ita,1,dimx*dimy);
        
        ew = zeros(1, 1024);
        ewa = zeros(1, 1024);
        
        k = 50;
        for j = 1:1024
            m = Ix(k);
            ew(j) = (It_rew(m)-It_re(m))/alpha;
            ewa(j) = (It_rea(m)-It_re(m))/alpha;           
            k = k+1;
        end
        sim = (ew*(ewa'))/sqrt(ewa*ewa');
        if isnan(sim)
            sim = 0;
        end
        
        if sim > 15
            result = 1;
        else
            result = 0;
        end
        
        wpsnr = WPSNR(attackedImage, watermarkedImage); 
    end