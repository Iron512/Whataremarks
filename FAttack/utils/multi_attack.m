function attackFunction = multi_attack(attackList)
    function image = attack(original_image, factors)
        
        alen = length(attackList);
        if alen ~= length(factors)
            fprintf("Attacks: %d - Factors: %d\n", alen, length(factors));
            throw(MException("MATLAB:narginchk:notEnoughInputs", "Wrong number of factors"));
        end
        image = double(original_image);        
        for i = 1:alen
           attack = attackList{i};
           image = attack(image, factors(i));
        end
        image = uint8(image);
    end
attackFunction=@attack;
end

