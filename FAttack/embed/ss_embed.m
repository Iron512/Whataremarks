function [embed_function] = ss_embed(alpha)
    function embeddedImage = embed_fn(originalImage, waterMark)
        originalImage = imread(originalImage);
        waterMark = double(waterMark(:));
        [dimx,dimy] = size(originalImage);
        It = dct2(double(originalImage));
        It_re = reshape(It,1,dimx*dimy);
        [~,Ix] = sort(abs(It_re),'descend');
        new_dct = It_re;

        k = 2;
        for j = 1:length(waterMark)
            m = Ix(k);
            new_dct(m) = It_re(m)*(1+(alpha*waterMark(j)));
            k = k+1;
        end


    It_newi=reshape(new_dct,dimx,dimy);

    embeddedImage = uint8(idct2(It_newi));
            
    end
    embed_function = @embed_fn;
end

