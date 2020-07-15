function  consequence = mulRANK(a) %a是一二维矩阵 m行数 n列数
m=size(a,1);   %a_row
n=size(a,2);    %a_column
for r=1:m
    %对角搞不不为0，进行换行实现
    if(a(r,r)==0)
       for rowBelow=r+1:m
           if a(rowBelow,r)~=0
              temp=a(r,:);
              a(r,:)=a(rowBelow,:);
              a(rowBelow,:)=temp;
              break;
           end
       end
    end
    %下行 找不到中间元素不为0的行
    if(a(r,r)==0)
       consequence=77;    %不满秩随便写一个值
       break;
    end
    %对角元素至1 （scale to 1）
    if(a(r,r)~=1)
       Spart=divide(1,a(r,r));
       for c=1:n
           a(r,c)=multipy(a(r,c),Spart);
       end
    end
    
    %对角元素 列对应下三角元素置0  r+1:m  1:n(11 21 31)
    for rowBelow=r+1:m
        if a(rowBelow,r)~=0
           backup=a(rowBelow,r);
           for c=1:n
               a(rowBelow,c)=bitxorPN(a(rowBelow,c),multipy(backup,a(r,c)));
           end
        end
    end  
    consequence=m;
end
%对角元素 列对应上三角元素置0   1:d  1:m(11 12 13) 可不要
% for d=1:m
%        for rowAbove=1:d-1
%            if(a(rowAbove,d)~=0)
%               backup=a(rowAbove,d);
%               for c=1:n
%                   a(rowAbove,c)=bitxorPN(a(rowAbove,c),multipy(backup,a(d,c)));
%               end
%            end
%        end 
% end
end