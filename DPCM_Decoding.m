function y= DPCM_Decoding(code)

dcode=[];
for i=1:length(code)
    if(i==1)
      dcode(i)=code(i);
    else
      dcode(i)=code(i)+dcode(i-1);
    end 
end
y=dcode;
end