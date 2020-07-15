function [a] = commondivisor(a,b)
    while(b)
        t=mod(a,b);
        a=b;
        b=t;
    end
end