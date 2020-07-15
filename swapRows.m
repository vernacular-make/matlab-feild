function aNew=swapRows(a,r1,r2)
    a_row=size(a,1);
    %a_column=size(a,2);
    if(r1<0 || a_row<r1 || r2<0 || a_row<r2)
       disp('行数超出索引');
    end
    temp=a(r1,:);
    a(r1,:)=a(r2,:);
    a(r2,:)=temp;
    aNew=a;
end