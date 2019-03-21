function [y] = funzione1v2(x,flag,fc,fs,k )

% implementazione funzione punto 1 
% usando direttamente il circuito e la funzione filter

%  x    -> segnale ingresso
%  flag -> H selezione + , L selezione -
%  fs   -> freq campionamento 
%  fc   -> [0,fs/2]
%  K    -> parametro funzione

%ALL PASS
alpha = (tan(pi*(fc/fs)) - 1) / (tan(pi*(fc/fs)) + 1);    
b = [alpha,1];
a = [1,alpha];

x1 = filter(b,a,x);

if(flag == 'H')
    x2 = x1 + x; 
else
    x2 = x1 - x;
end

y = x + x2*(k/2);

end

