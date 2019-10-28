function time = evaluate_function(fn,varargin)
a = now;
fn(varargin{:});
time = (now-a)*100000000;
end

