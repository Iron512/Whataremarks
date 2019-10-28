function [embed_function] = lsr_embed(bit)
    function embeddedImage = embed_fn(originalImage, waterMark)
        originalImage = imread(originalImage);
        [width, height] = size(originalImage);
        waterMark = expand_matrix(waterMark, width, height);
        embeddedImage = bitset(originalImage, bit, waterMark);
    end
    embed_function = @embed_fn;
end

