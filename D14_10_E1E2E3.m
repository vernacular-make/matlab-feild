clc;
clear;
n = 14;  %�ڵ�����
k = 10;  %���ݽڵ�ĸ���
q = 256;   %�������С
p=[1,2,3,4,5,6,7,8,9,10]; %%p1^2��p10^2 mod q
for j=1:10
   double(j) =multipy(p(j),p(j)) ;
   three(j) = multipy(double(j),p(j));
end
B = (-127:128);
set = nchoosek(B,2);
a = size(set,1); %���ؾ��������
countNUM = 0;
for Row_N = 1:a
%     subset = set(i,:);
%     Ydisorder = perms(subset);%���п�������
%     sizeofYdisorder = size(Ydisorder,1);%���������п������_ȡ���������п��ܵ�ѡ��C256_9
%     %��11������ѡ��7���������������ģ�Ϊ���������������λ������Ȼ�������p1��p5,e1,e2
      disp('*****************');
      disp(Row_N);
      subset=set(Row_N,:);
      disp(subset);
      e1=subset(1);
      e2=subset(2);
      if e1 == 0 || e1 == 1||e2 == 0 || e2 == 1 || e1==e2 
         continue;
      end
        %��ȷ������e1,e2(��ǰ���б�������MDS���ԵĲ���)
        %������
        A=zeros(20,28);      
        a1=1;b1=1;                                                      
        e=[e1,e2];
        for j = 0:1                              %% ǰ20*8������� (ǰ4���ڵ�����)
            a1=a1+2*j;                           %ÿ�����Ա任��ͷԪ�����(d-k+1)*jλ��   ����d-k+1Ϊ2
            b1=b1+4*j;                           %4=2*2��2���ڵ�*2���ӷְ���
            e_1=e(j+1);                           
            A(a1,b1)=1;
            A(a1+1,b1+1) = e_1;
            A(a1+1,b1+2) = 1;
            A(a1+10,b1+1) = 1;
            A(a1+10,b1+2) = 1;
            A(a1+11,b1+3) = 1;
            a1=1;b1=1; 
        end
        % ��20*9_20������� (5 6 7 8 9 10�ڵ�����)
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
        % ���20*21_28������� (11 12 13 14�ڵ�����)
        for j=0:1
           for num=1:4
             for i=1:10
               A(i+j*10,21+j+(num-1)*2)=PP(num,i);
             end
           end
        end
        %5��14����ѡ8���ڵ�
        combos = nchoosek(5:14,8);
        sizeofcom = size(combos,1);
        %1��6�ڵ�ѡ����Ҫ���ǵ�2���ڵ����  ��2�����
        consider=[1 4;2 3];
        %���һ���µĲ�������
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