function  consequence = mulRANK(a) %a��һ��ά���� m���� n����
m=size(a,1);   %a_row
n=size(a,2);    %a_column
for r=1:m
    %�ԽǸ㲻��Ϊ0�����л���ʵ��
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
    %���� �Ҳ����м�Ԫ�ز�Ϊ0����
    if(a(r,r)==0)
       consequence=77;    %���������дһ��ֵ
       break;
    end
    %�Խ�Ԫ����1 ��scale to 1��
    if(a(r,r)~=1)
       Spart=divide(1,a(r,r));
       for c=1:n
           a(r,c)=multipy(a(r,c),Spart);
       end
    end
    
    %�Խ�Ԫ�� �ж�Ӧ������Ԫ����0  r+1:m  1:n(11 21 31)
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
%�Խ�Ԫ�� �ж�Ӧ������Ԫ����0   1:d  1:m(11 12 13) �ɲ�Ҫ
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