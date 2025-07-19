function x = mySolveTriDiag(a,b,c,d)
%format long; format compact;
if (length(a)==length(b) && length(b)==length(c) && length(c)==length(d))
    P =length(a);

    %forward elimination
    for i = 2:P
        b(i)=b(i)-(c(i-1).*a(i)./b(i-1));
        d(i)=d(i)-(d(i-1).*a(i)./b(i-1));
    end

    %back-substitution
    d(P)=d(P)./b(P);
    for i=P-1:-1:1
        d(i)=(d(i)-c(i).*d(i+1))./b(i);
    end
    x=d;
else
    error ERROR Make all vectors of same length!
end


