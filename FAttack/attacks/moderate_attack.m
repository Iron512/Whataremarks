function att = moderate_attack(attackFunction)
    function rimg = attack(image, factor)
        aimg = attackFunction(image, factor);
        rimg = (factor.*aimg)+((1-factor).*image);
    end
    att = @attack;
end

