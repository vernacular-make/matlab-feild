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
set = nchoosek(B,3);
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
      e1=x;
      e2=y;e3=z;
      e4=subset(1);
      e5=subset(2);
      e6=subset(3);
      if e4 == 0 || e4 == 1||e5 == 0 || e5 == 1 ||e6 == 0 || e6 == 1 || e4==e5 ||e4==e6 ||e5==e6 || e4==e1 || e4==e2 ||e4==e3 || e5==e1 || e5==e2 ||e5==e3 || e6==e1 || e6==e2 ||e6==e3 
         continue;
      end
      
        A=zeros(40,56);      
        a1=1;b1=1;                                                      
        e=[e1,e2,e3,e4,e5,e6];
        % ǰ40*24������� (ǰ6���ڵ�����)  
        %ÿ�����Ա任��ͷԪ�����(d-k+1)*jλ�� 
        %8=2*4��2���ڵ�*4���ӷְ���
        for c=0:1
          for j = 0:2                              
                a1=a1+2*j;                            
                b1=b1+8*j;                          
                e_1=e(j+1);                           
                A(a1+20*c,b1+2*c)=1;           %20=40/2
                A(a1+20*c+1,b1+2*c+1) = e_1;
                A(a1+20*c+1,b1+2*c+4) = 1;
                A(a1+20*c+10,b1+2*c+1) = 1;
                A(a1+20*c+10,b1+2*c+4) = 1;
                A(a1+20*c+11,b1+2*c+5) = 1;
                a1=1;b1=1; 
          end
        end
        
      % ��20*24_40������� (7 8 9 10�ڵ�����)
      a2=7;b2=25;
      for c=0:1
          for j = 0:1                              
                a2=a2+10*c+2*j;                            
                b2=b2+c+8*j;                          
                e_1=e(3+j+1);                           
                A(a2,b2)=1;             
                A(a2+1,b2+2) = e_1;
                A(a2+1,b2+4) = 1;
                A(a2+20,b2+2) = 1;
                A(a2+20,b2+4) = 1;
                A(a2+21,b2+6) = 1;
                a2=7;b2=25; 
          end
      end
       
      %ĩβ20*40_56������� (11 12 13 14�ڵ�����)
      for j=1:10     
          E6mulp(j)=multipy(p(j),e6);
      end
        PP=zeros(5,10);
        PP(1,:)=1;
        PP(2,:)=p;
        PP(3,:)=double;
        PP(4,:)=three;
        PP(5,:)=E6mulp;
        for j=0:3
           for num=1:4
             for i=1:10
               A(i+j*10,41+j+(num-1)*4)=PP(num,i);    
             end
           end
        end
        
        for j=0:1
            for i=1:10
                A(i+j*10,43+j)=PP(5,i);
                A(i+(j+2)*10,45+j)=PP(1,i);
            end
        end
       

        %7��14����ѡ6���ڵ�
        pond=[1 2 3 4 5 6 13 14];       %ѡ���
        combos = nchoosek(pond,6);
        sizeofcom = size(combos,1);
        %7��12�ڵ�ѡ����Ҫ���ǵ�4���ڵ����  ��6�����
        consider=[7 8 9 12;7 8 10 11;8 9 11 12;7 10 11 12;8 9 10 11;7 9 10 12];
        %���һ���µĲ�������
        combos1=zeros(6*sizeofcom,10);
        for i=1:6
            for j=1:sizeofcom
                combos1((i-1)*sizeofcom+j,1:4)=consider(i,:);
                combos1((i-1)*sizeofcom+j,5:10)= combos(j,:);
            end
        end
        H = zeros(k*4,k*4);
        booleanH = 1;
        for i1 = 1:6*sizeofcom
            tempcom = combos1(i1,:);
            for i2 = 1:k
                H(:,4*i2) = A(:,2*tempcom(i2));
                H(:,4*i2-1) = A(:,2*tempcom(i2)-1); 
                H(:,4*i2-2) = A(:,2*tempcom(i2)-2);
                H(:,4*i2-3) = A(:,2*tempcom(i2)-3);
            end
            rankofH = mulRANK(H);
            disp(rankofH)
            if rankofH ~= k*4
                booleanH = 0;
                break;
            end
        end
        if booleanH == 1
            countNUM = countNUM + 1;
            disp('*****************');
            disp(countNUM);
            disp(e4);
            disp(e5);
            disp(e6);
            break;
        end
end