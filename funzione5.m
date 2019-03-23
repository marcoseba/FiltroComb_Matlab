function [ y ] = funzione5( x,flag,b,a,k)

%implementazione circuito 1 con filtro all-pass di grado N qualsiasi

% y -> segnale uscita
% x -> segnale ingresso
% b -> vett coeff. numeratore all-pass
% a -> vett coeff. denominatore all-pass
% k -> parametro circuito

%passare dalla funzione A(z) alla funzione H(z) circuto primo punto
% A(z) = b/a  --> Hsomma(z) = Bsomma/A , Hdiff(z) = Bdiff/A

A = a;
if(flag == 'H')
    B = a*(1+k/2) + k/2*b; %modo somma
else
    B = a*(1-k/2) + k/2*b; %modo diffrenza
end

%Implementazione filtro IIR grado N

%normalizzazione coeff a rispetto ad a(1)
B = B / A(1);
A = A / A(1);

Nb = length(B); %numero zeri
Na = length(A); %numero poli
N = length(x);

w = zeros(N,1); %inzialiazzione vettori
y = zeros(N,1);

% parte zeri
for i=1:N
    for j=1:Nb
        if i>=j
            w(i)=w(i)+B(j)*x(i-j+1);
        end;
    end;
end;

% parte poli
for i=1:N
    for j=1:Na
        if i>=j
            y(i) = y(i) + A(j) * y(i-j+1); 
        end;
    end;
    y(i) = w(i) - y(i);
end;

end

