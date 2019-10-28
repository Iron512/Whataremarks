function void = print_vector(vector)
%PRINT_VECTOR Summary of this function goes here
%   Detailed explanation goes here
void = 0;
for i=1:length(vector)
   if i ~= 1
       fprintf(", %f", vector(i));
   else
       fprintf("%f", vector(i));
   end
end
end

