function y= RLDecoding(sig)
k=1;
c=1;
code=[];

siga=str2num(sig);

for i=2:2:length(siga);
    for j=1:siga(i)
        code=[code,siga(i-1)];
    end
end

y=code;
end