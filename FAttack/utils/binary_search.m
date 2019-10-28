function [res,value,out,img] = binary_search(func, min, max, minstep, minout, lastout, lastimg, varargin)
%BINARY_SEARCH Summary of this function goes here
%   Detailed explanation goes here
step = (max-min)/2;
m = min;
vars = varargin{:};
for i = 1:1
    val = i.*step+min;
    [r, out, img] = func(val, vars);
    
    if r == 0
        res = 0;
        value = [val, val];
        return;
    elseif r > 0
        
        m = val;
        if out < minout
            res = -2;
            value = [m, max];
            return;
        end
        out = lastout;
        img = lastimg;
    else
        lastout = out;
        lastimg = img;
        max = val;
        break;
    end
end
if step < minstep
    res = -1;
    value = [m, max];
    return;
end
[res, value, out, img] = binary_search(func, m, max, minstep, minout, lastout, lastimg, vars);
end

