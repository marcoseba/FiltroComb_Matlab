function [ b,a ] = myAllPass(grad,M)

% grad -> grado del filtro all pass, se non è pari verrà arrotondato
% M -> modulo dei coefficienti
% b -> vettore coeff. numeratore all pass
% a -> vettore coedd denominatore all pass


if(M>1 || M<0) %filtro instabile
    error('valore M non valido');
end

N = floor(grad/2);

beta = 1/(N+1):1/(N+1):1;
beta = pi*beta;

% passo 1
b = [M^2 -M*exp(1i*beta(1))-M*exp(-1i*beta(1)) 1];

for i= 2:N
    
bp=[M^2 -M*exp(1i*beta(i))-M*exp(-1i*beta(i)) 1];

b = conv(b,bp);

end

a = fliplr(b);

end

