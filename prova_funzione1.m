%prova funzione 1
clear all 
close all

%FILTRO ALL PASS al variare del rapporto 
%r = fc/fs; fc -> ]0,fs/2[ 
%quindi r -> ]0,0.5[
r = 0.1;
alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);  
b = [alpha,1];
a = [1,alpha];
figure; freqz(b,a); title('all-pass');
 
k = 0.8;

%IMPLEMENTAZIONE FUNZIONE CON SEGNO +

b1 = [(2+k+k*alpha),(2*alpha+k+k*alpha)];
a1 = [2,(2*alpha)];

figure; freqz(b1,a1);title('funzione segno +');

%IMPLEMENTAZIONE FUNZIONE CON SEGNO -

b2 = [(2+k*alpha-k),(2*alpha+k-k*alpha)];
a2 = [2,(2*alpha)];

figure; freqz(b2,a2);title('funzione segno -');

%PROVA RUMORE BIANCO
x=0.4*rand(10000,1); % Additive white Gaussian noise 
Fs = 48000;
figure;spectrogram(x,2046,1024,2046,48000);title('rumore ingresso');
y = filter(b1,a1,x);
figure;spectrogram(y,2046,1024,2046,48000);title('uscita filtro');

%IMPLEMENTAZIONE FUNZIONE CON SEGNO + per diversi valori di k
% figure;
% for k=0.01: 0.2 : 1
% 
% alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);    
% b1 = [(2+k+k*alpha),(2*alpha+k+k*alpha)];
% a1 = [2,(2*alpha)];
% 
%     
% [h1,w1]  = freqz(b1,a1);  %modulo (h1 = num complesso)
% [phi,w2] = phasez(b1,a1); %fase
% 
% %disegno grafico
% subplot(2,1,1);
% plot(w1/pi,20*log10(abs(h1)));grid on;hold on
% title({'funzione 1 somma';'modulo (db)'})
% subplot(2,1,2);
% plot(w2/pi,radtodeg(phi));grid on;hold on
% title('fase (deg)')
% 
% end
% 
% 
% %IMPLEMENTAZIONE FUNZIONE CON SEGNO - per diversi valori di k
% figure;
% for k=0.01: 0.2 : 1
%     
% 
% alpha = (tan(pi*r) - 1) / (tan(pi*r) + 1);    
% b1 = [(2+k*alpha-k),(2*alpha+k-k*alpha)];
% a1 = [2,(2*alpha)];
% 
%     
% [h1,w1]  = freqz(b1,a1);  %modulo (h1 = num complesso)
% [phi,w2] = phasez(b1,a1); %fase
% 
% %disegno grafico
% subplot(2,1,1);
% plot(w1/pi,20*log10(abs(h1)));grid on;hold on
% title({'funzione 1 differenza';'modulo (db)'})
% subplot(2,1,2);
% plot(w2/pi,radtodeg(phi));grid on;hold on
% title('fase (deg)')
% 
% end


%controprova con implementzione diretta
x1 = filter(b,a,x);
x2 = x1 + x;  %scegliere -/+
y2 = x + x2*(k/2);
figure;spectrogram(y2,2046,1024,2046,48000);title('uscita filtro controprova');

diff = y-y2;
err = sum(diff) / length(diff);
%ok! le due implementazioni sono equivalenti

