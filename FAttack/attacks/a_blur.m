function [att, inputs] = a_blur(image, factor)
factor = 30.*factor+0.000001;
att = test_blur(image, factor);
inputs = [factor];
