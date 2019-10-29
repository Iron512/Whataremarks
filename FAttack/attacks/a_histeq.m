function [att, inputs] = a_histeq(image,factor)
factor = round(1024-factor.*1022);
att = test_equalization(uint8(image), factor);
inputs = [factor];
end

