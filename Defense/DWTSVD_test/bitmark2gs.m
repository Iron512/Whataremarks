function mark_gs = bitmark2gs(mark)
mark_gs = zeros(16,8);
mark = mark/255;

for i = 0:15
   for j = 0:7
      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 128 * mark(i*2+1,j*4+1);
      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 64 * mark(i*2+1,j*4+2);
      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 32 * mark(i*2+1,j*4+3);
      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 16 * mark(i*2+1,j*4+4);

      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 8 * mark(i*2+2,j*4+1);
      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 4 * mark(i*2+2,j*4+2);
      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 2 * mark(i*2+2,j*4+3);
      mark_gs(i+1,j+1) = mark_gs(i+1,j+1) + 1 * mark(i*2+2,j*4+4);
   end
end

mark_gs = uint8(mark_gs);
