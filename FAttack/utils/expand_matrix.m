function matrix = expand_matrix(originalData,width, height)
%EXPAND_MATRIX Summary of this function goes here
%   Detailed explanation goes here
vec = originalData(:);
len = length(vec);
matrix = zeros(width, height);
    for i=1:(width*height)
        x = mod(i, width)+1;
        y = ceil(i/width);
        matrix(x,y)=vec(mod(i,len)+1);
    end
end

