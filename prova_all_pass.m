%prova filtro all-pass
clear all 
close all

index =0.001: 0.1 : 0.5;

%FILTRO ALL PASS al variare del rapporto 
%r = fc/fs; fc -> ]0,fs/2[ 
%quindi r -> ]0,0.5[
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


k=0.5;
figure;
for r=0.01: 0.08 : 0.5
%r = 0.25;
%for k=0.01: 0.2 : 1   

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