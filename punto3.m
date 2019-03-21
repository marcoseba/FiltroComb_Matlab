% punto 3
clear all
close all

[x,fs] = audioread('Rumore_bianco.wav');
%x(:,1) = []; %se segnale stereo
x = x';

fc = 0.5*(fs/2); %normalizzo rispetto a fs/2
k = 0.95;

figure;spectrogram(x,512,256,512);title('segnale ingresso');

y1 = funzione1v2(x,'L',fc,fs,k);
y = funzione1v2(y1,'H',fc,fs,k);
figure;spectrogram(y,512,256,512);title('segnale uscita');

%filtro all pass A(z)
alpha = (tan(pi*(fc/fs)) - 1) / (tan(pi*(fc/fs)) + 1);    
b = [alpha,1];
a = [1,alpha];
%figure;freqz(b,a);title('filtro all-pass');

%FUNZIONE1 MODALITA' OPERTATIVA H (segno +)
b1 = [(2+k+k*alpha),(2*alpha+k+k*alpha)];
a1 = [2,(2*alpha)];

%FUNZIONE1 MODALITA' OPERTATIVA L (segno -)
b2 = [(2+k*alpha-k),(2*alpha+k-k*alpha)];
a2 = [2,(2*alpha)];

%cascata delle due funzioni1 L e H
b3 = conv(b1,b2);
a3 = conv(a1,a2);

figure;freqz(b3,a3);title('cascata');
yv = filter(b3,a3,x);
figure;spectrogram(yv,512,256,512);

%controllo che le due implementazioni sono equivalenti
diff = yv - y;
err = sum(diff) / length(diff);