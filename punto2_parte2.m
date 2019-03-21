%punto2 parte 2

clear all 
close all

% in questo script valuto i diagrammi di modulo e fase 
% della funzione1 impelmentata dal 
% circuito al variare di k
% mentre uso un rapporto  r = fc/fs; costante

r = 0.1; %r -> ]0,0.5[

% filtro all-pass
alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);  
b = [alpha,1];
a = [1,alpha];
figure; freqz(b,a); title('all-pass');



%FUNZIONE1 MODALITA OPERATIVA H (segno +)
figure;
for k=0.01: 0.2 : 1

alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);    
b1 = [(2+k+k*alpha),(2*alpha+k+k*alpha)];
a1 = [2,(2*alpha)];

    
[h1,w1]  = freqz(b1,a1);  %modulo (h1 = num complesso)
[phi,w2] = phasez(b1,a1); %fase

%disegno grafico
subplot(2,1,1);
plot(w1/pi,20*log10(abs(h1)));grid on;hold on
title({'funzione 1 somma';'modulo (db)'})
subplot(2,1,2);
plot(w2/pi,radtodeg(phi));grid on;hold on
title('fase (deg)')

end


%FUNZIONE1 MODALITA OPERATIVA L (segno -) 
figure;
for k=0.01: 0.2 : 1
    

alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);    
b1 = [(2+k*alpha-k),(2*alpha+k-k*alpha)];
a1 = [2,(2*alpha)];

    
[h1,w1]  = freqz(b1,a1);  %modulo (h1 = num complesso)
[phi,w2] = phasez(b1,a1); %fase

%disegno grafico
subplot(2,1,1);
plot(w1/pi,20*log10(abs(h1)));grid on;hold on
title({'funzione 1 differenza';'modulo (db)'})
subplot(2,1,2);
plot(w2/pi,radtodeg(phi));grid on;hold on
title('fase (deg)')

end

% CONSIDERAZIONI
% al variare di k nella funzione1 somma varia il punto di partenza 
% della curva nel diagramma di modulo, in particolare per k crescente
% la curva parte da valori (dB) più elevati;(maggiore amplificazione).
% Nella funzione1 differenza varia il punto di arrivo della curva nel 
% diagramma di modulo, in particolare per valori di k crescenti 
% la curva finisce in valori (dB) più negativi;(maggior attenuazione)
