clc;
clear;
n = 14;  %节点总数
k = 10;  %数据节点的个数
q = 256;   %有限域大小
p=[1,2,3,4,5,6,7,8,9,10]; %%p1^2到p10^2 mod q
for j=1:10
   double(j) =multipy(p(j),p(j)) ;
   three(j) = multipy(double(j),p(j));
end
B = (-127:128);
set = nchoosek(B,2);
a = size(set,1); %返回矩阵的行数
countNUM = 0;
for Row_N = 1:a
%     subset = set(i,:);
%     Ydisorder = perms(subset);%所有可能排序
%     sizeofYdisorder = size(Ydisorder,1);%遍历后所有可能情况_取行数即所有可能的选择—C256_9
%     %从11个数中选择7个数，组合是有序的，为了所有情况，需移位遍历，然后填充至p1到p5,e1,e2
      disp('*****************');
      disp(Row_N);
      subset=set(Row_N,:);
      disp(subset);
      e1=subset(1);
      e2=subset(2);
      if e1 == 0 || e1 == 1||e2 == 0 || e2 == 1 || e1==e2 
         continue;
      end
        %先确定参数e1,e2(即前四列编码满足MDS属性的参数)
        %填充矩阵
        A=zeros(20,28);      
        a1=1;b1=1;                                                      
        e=[e1,e2];
        for j = 0:1                              %% 前20*8矩阵填充 (前4个节点的填充)
            a1=a1+2*j;                           %每个线性变换开头元素相差(d-k+1)*j位数   这里d-k+1为2
            b1=b1+4*j;                           %4=2*2（2个节点*2个子分包）
            e_1=e(j+1);                           
            A(a1,b1)=1;
            A(a1+1,b1+1) = e_1;
            A(a1+1,b1+2) = 1;
            A(a1+10,b1+1) = 1;
            A(a1+10,b1+2) = 1;
            A(a1+11,b1+3) = 1;
            a1=1;b1=1; 
        end
        % 中20*9_20矩阵填充 (5 6 7 8 9 10节点的填充)
        a2=5;b2=9;
        for j = 0:1                            
            a2=a2+10*j;                          
            b2=b2+j;                           
            for i=0:5
                A(a2+i,b2+2*i)=1;
            end
            a2=5;b2=9;
        end
        
        PP=zeros(4,10);
        PP(1,:)=1;
        PP(2,:)=p;
        PP(3,:)=double;
        PP(4,:)=three;
        % 最后20*21_28矩阵填充 (11 12 13 14节点的填充)
        for j=0:1
           for num=1:4
             for i=1:10
               A(i+j*10,21+j+(num-1)*2)=PP(num,i);
             end
           end
        end
        %5到14任意选8个节点
        combos = nchoosek(5:14,8);
        sizeofcom = size(combos,1);
        %1到6节点选必须要考虑的2个节点组合  有2种情况
        consider=[1 4;2 3];
        %组成一个新的参数矩阵
        combos1=zeros(2*sizeofcom,10);
        for i=1:2
            for j=1:sizeofcom
                combos1((i-1)*sizeofcom+j,1:2)=consider(i,:);
                combos1((i-1)*sizeofcom+j,3:10)= combos(j,:);
            end
        end
        
        H = zeros(k*2,k*2);
        booleanH = 1;
        for i1 = 1:2*sizeofcom
            tempcom = combos1(i1,:);
            for i2 = 1:k
                H(:,2*i2) = A(:,2*tempcom(i2));
                H(:,2*i2-1) = A(:,2*tempcom(i2)-1); 
            end
            rankofH = mulRANK(H);
            if rankofH ~= k*2
                booleanH = 0;
                disp(i1);
                break;
            end
        end
        if booleanH == 1
            countNUM = countNUM + 1;
            disp('*****************');
            disp(countNUM);
            disp(p);
            disp(e1);
            disp(e2);
            disp(e3);
            break;
        end
end