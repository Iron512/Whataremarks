
function [result, wpsnr, sim] = ss_detect(originalImage, watermarkedImage, attackedImage)
alpha = 15;
        watermarkedImage = imread(watermarkedImage);
        originalImage = imread(originalImage);
        attackedImage = imread(attackedImage);
        
        
        [~,U] = lu(dct2(double(originalImage)));
        [dimx,dimy] = size(U);
        It_re = reshape(U,1,dimx*dimy);
        [~,Ix] = sort(abs(It_re),'descend');
        
        [~,Uw] = lu(dct2(double(watermarkedImage)));
        It_rew = reshape(Uw,1,dimx*dimy);
        
        [~,Ua] = lu(dct2(double(attackedImage)));
        It_rea = reshape(Ua,1,dimx*dimy);
        
        ew = zeros(1, wsize);
        ewa = zeros(1, wsize);
        
        k = 100;
        for j = 1:wsize
            m = Ix(k);
            ew(j) = max(min(round((It_rew(m)-It_re(m))/alpha), 1),0);
            ewa(j) = max(min(round((It_rea(m)-It_re(m))/alpha), 1),0);           
            k = k+1;
        end
        sim = (ew*(ewa'))/sqrt(ewa*ewa');
        if isnan(sim)
            sim = 0;
        end
        
        if sim > 14
            result = 1;
        else
            result = 0;
        end
        
        wpsnr = WPSNR(attackedImage, watermarkedImage); 
    end
    