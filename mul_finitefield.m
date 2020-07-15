clc;
clear;
p1=input('请输入一个整数：');
e1=input('请输入一个整数：');
p=dec2bin(p1,8);  %10进制数转成8位二进制数
e=dec2bin(e1,8);

a=zeros(9,8);
a(1,:)=double(dec2bin(1,8))-'0';

p_m=zeros(8,8);             %初始化矩阵 存放 p及0x01 ox02 0x04 0x08 0x10 0x20 0x30 0x40 0x80 分别乘以p的计算值
p_m(1,:)=double(p)-'0';

e_first=zeros(1,8);
e_first=double(e)-'0';


B=zeros(8,8);
for i=2:8
    n=1;            %%移动多少位
    B(i,1:end-n)=a(i-1,n+1:end);%左移
    a(i,:)=B(i,:);  %%得到0x01 ox02 0x04 0x08 0x10 0x20 0x30 0x40 0x80 存在矩阵a中
end

%计算0x01 ox02 0x04 0x08 0x10 0x20 0x30 0x40 0x80 分别乘以p（十进制数—二进制）的情况
 poly_bit=[0 0 0 1 1 0 1 1];%有限域256不可约多项式同余 +0x1B
 theone=[1 1 1 1 1 1 1 1];
 allzero=[0 0 0 0 0 0 0 0];
 for i=2:9
    if(p_m(i-1,1)==1)
        p_m(i,1:end-n)=p_m(i-1,n+1:end);
        p_m(i,end-n+1:end)=0;
        p_m(i,:)=xor(p_m(i,:),poly_bit);
    else
        p_m(i,1:end-n)=p_m(i-1,n+1:end);
        p_m(i,end-n+1:end)=0;
%         p_m(i,:)&=theone;
    end
 end

order=[1 2 3 4 5 6 7 8];
disorder=[8 7 6 5 4 3 2 1];
consequence=allzero;
 for i=1:8
     if(e_first(i)==1)
        consequence=xor(p_m(disorder(i)+1,:),consequence);
     end
 end
 
 result=bin2dec(num2str(consequence));
