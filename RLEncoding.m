function y= RLEncoding(sig)
k=1;
c=1;

for i=1:length(sig);    
    f(k,1)=sig(i);
    
     if (i==length(sig))
        f(k,2)=c;
     else if(sig(i)==sig(i+1))
        c=c+1;
    else
        f(k,2)=c;
        k=k+1;
        c=1;
         end 
     end
end

code=[];
for i=1:length(f);
   code=[code,f(i,1),f(i,2)];   
end

y=code;
end