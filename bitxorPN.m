function c = bitxorPN(a,b)    %�����ư�λ���
    a1=dec2binPN(a,8);
    b1=dec2binPN(b,8);
    for i=1:length(b1)
        c1(i)=xorPN(a1(i),b1(i));
    end
    c=bin2dec(num2str(c1));
    if c>128
        c=c-256;
    end
end