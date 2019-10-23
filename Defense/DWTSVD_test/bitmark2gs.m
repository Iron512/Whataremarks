function mark_gs = bitmark2gs(mark)
mark_gs = zeros(32,16);

for i=(1:32)
    for j=(0:15)
        mark_gs(i,j+1) = mark(i,j*2+1)*2 + mark(i,j*2+2);
    end
end

mark_gs = uint8(mark_gs);
