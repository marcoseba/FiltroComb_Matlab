function [y] = funzione1(x,flag,fc,fs,k )
 
%implementazione funzione punto 1 

%  x    -> segnale ingresso
%  flag -> H selezione + , L selezione -
%  fs   -> freq campionamento 
%  fc   -> [0,fs/2]
%  K    -> parametro funzione


%calcolo coeff filtro all-pass
alpha = (tan(pi*(fc/fs)) - 1) / (tan(pi*(fc/fs)) + 1);  

a = [2,(2*alpha)];

if(flag == 'H') %implementazione segno +
    b = [(2+k+k*alpha),(2*alpha+k+k*alpha)];
    
else %implementazione segno -
   b = [(2+k*alpha-k),(2*alpha+k-k*alpha)];
end

%figure; freqz(b,a);title('funzione');

%IMPLEMENTAZIONE IIR diretta con solo 1 polo e 1 zero

%normalizzazione coeff a rispetto ad a(1)
b = b / a(1);
a = a / a(1);

%inizializzazione vettori
y = zeros(1,length(x)); 
w = zeros(1,length(x));

%parte zeri
w(1) = x(1)*b(1); %passo 1
for i=2:length(x) %altri passi
   w(i) = x(i)*b(1) + x(i-1)*b(2); 
end

%parte poli
y(1) = w(1);
for i=2:length(x) %altri passi
   y(i) = w(i) - y(i-1)*a(2); 
end

end

