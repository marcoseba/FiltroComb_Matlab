function [ y ] = funzione5v2( x,flag,b,a,k)

%implementazione diretta del circuito 1 con filtro all-pass 
%di grado N qualsiasi usando la funzione filter

% y -> segnale uscita
% x -> segnale ingresso
% b -> vett coeff. numeratore all-pass
% a -> vett coeff. denominatore all-pass
% k -> parametro circuito

x1 = filter(b,a,x);

if(flag == 'H')
    x2 = x1 + x; 
else
    x2 = x1 - x;
end

y = x + x2*(k/2);


end

