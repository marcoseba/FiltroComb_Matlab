%prova cascata 
% disegno diagramma modulo fase delle funzioni
% in cascata al variare di k

clear all
close all

fs = 1;

%parametri
fc = 0.5*(fs/2); %normalizzo rispetto a fs/2
r = fc/fs;

%filtro all pass A(z)
alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);    
b = [alpha,1];
a = [1,alpha];
figure;freqz(b,a);


for k =0.1 : 0.2 : 1
%k = 0.95;
%FUNZIONE1 MODALITA' OPERTATIVA H (segno +)
b1 = [(2+k+k*alpha),(2*alpha+k+k*alpha)];
a1 = [2,(2*alpha)];

%FUNZIONE1 MODALITA' OPERTATIVA L (segno -)
b2 = [(2+k*alpha-k),(2*alpha+k-k*alpha)];
a2 = [2,(2*alpha)];

%cascata delle due funzioni1 L e H
b3 = conv(b1,b2);
a3 = conv(a1,a2);

%disegno grafico
[h1,w1]  = freqz(b3,a3);  %modulo (h1 = num complesso)
[phi,w2] = phasez(b3,a3); %fase

subplot(2,1,1);
plot(w1/pi,20*log10(abs(h1)));grid on;hold on
title({'funzione 1 differenza';'modulo (db)'})
subplot(2,1,2);
plot(w2/pi,radtodeg(phi));grid on;hold on
title('fase (deg)')

end

% CONSIDERAZIONI 
% la cascata delle due funzioni L e H ha l effetto di amplificare le
% freq precedenti a fc mentre attenua le frequenze successive a fc
% questo effetto è tanto piu maggiore tanto piu è alto il valore di k
% per k -> 0 si comporta da all-pass 
% la fase è "abbastanza" lineare nella parte amplificata.

% se k è maggiore di 1 l'effetto non è più quello descritto


