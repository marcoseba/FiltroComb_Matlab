%punto 2 parte 1
clear all 
close all

% in questo script valuto i diagrammi di modulo e fase del filtro
% all-pass A(z) e della funzione1 impelmentata dal 
% circuito al variare di fc -> ]0,fs/2[ 
% quindi del rapporto  r = fc/fs; r -> ]0,0.5[
% mentre uso un k costante


k=0.5;


%FILTRO ALL PASS
figure;        
for r=0.01: 0.08 : 0.5
    

alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);    
b = [alpha,1];
a = [1,alpha];

    
[h1,w1]  = freqz(b,a);  %modulo (h1 = num complesso)
[phi,w2] = phasez(b,a); %fase

%disegno grafico
subplot(2,1,1);
plot(w1/pi,20*log10(abs(h1)));grid on;hold on
title({'filtro all-pass';'modulo (db)'})
subplot(2,1,2);
plot(w2/pi,radtodeg(phi));grid on;hold on
title('fase (deg)')

end



%FUNZIONE1 MODALITA' OPERTATIVA H (segno +)
figure;
for r=0.01: 0.08 : 0.5
 
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

%FUNZIONE1 MODALITA' OPERTATIVA L (segno -)
figure;
for r=0.01: 0.08 : 0.5
    

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
% il filtro all-pass al variare di fc mantiene una risposta in modulo
% pari a 0dB (come è ovvio che sia) mentre varia la sua risposta in fase
% in particolare per fc -> 0 tende a sfasare tutte le freq di 180°,
% per fc = fs/4 ha una risposta lineare, per fc -> fs/2 tende a non sfasare
% per valori intermedi si avranno curve intermedie

% la funzione1 traspone il diagramma di fase del filtro all-pass nel 
% suo diagramma di modulo, in particolare la funzione1 somma parte
% da valori postivi (dB) e finisce a 0 dB
% mentre la funzione1 differenza parte da valori di 0 dB e finisce a 
% valori negativi (dB)
