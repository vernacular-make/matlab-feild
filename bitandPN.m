function c = bitandPN(a,b)    %∞¥Œª”Î
    a1=dec2binPN(a,8);
    b1=dec2binPN(b,8);
    for i=1:length(b1)
        c1(i)=andPN(a1(i),b1(i));
    end
    
    c=bin2dec(num2str(c1));
end