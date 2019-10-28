function att = a_histeq(image,factor)
att = double(histeq(uint8(image), round(1024-factor.*1022)));
end

