% punto 3 e 4
clear all
close all

% SEGANLE INGRESSO
[x,fs] = audioread('Rumore_bianco.wav');
%x(:,1) = []; %se segnale stereo
x = x';

% SETTAGGIO PARAMETRI 
fc = 0.5*(fs/2); %normalizzo rispetto a fs/2
k = 0.95;

%PUNTO 3 
figure;spectrogram(x,512,256,512);title('segnale ingresso');
y1 = funzione1(x,'L',fc,fs,k);
y = funzione1(y1,'H',fc,fs,k);
figure;spectrogram(y,512,256,512);title('segnale uscita');


% F.D.T. COMPLESSIVA CASCATA
%filtro all pass A(z)
alpha = (tan(pi*(fc/fs)) - 1) / (tan(pi*(fc/fs)) + 1);    
b = [alpha,1];
a = [1,alpha];
%figure;freqz(b,a);title('filtro all-pass');

%funzione1 modalita operativa H (segno +)
b1 = [(2+k+k*alpha),(2*alpha+k+k*alpha)];
a1 = [2,(2*alpha)];

%funzione1 modalita operativa L (segno -)
b2 = [(2+k*alpha-k),(2*alpha+k-k*alpha)];
a2 = [2,(2*alpha)];

%cascata delle due funzioni1 L e H
b3 = conv(b1,b2);
a3 = conv(a1,a2);

figure;freqz(b3,a3);title('cascata');
yv = filter(b3,a3,x);



% PUNTO 4 
figure;grpdelay(b3,a3);title('ritardo di gruppo');

% CONSIDERAZIONI
% Il ritardo a fc è di circa 0.5 campioni
% Il numero di operazioni eseguite per ogni campione
% è di 3 prodotti e 2 somme per ogni funzione1.
% quindi se messi in cascata due funizone1 nelle diverese
% modalita operative il numero di operazioni totali sarà
% di 6 prodotti e 4 somma.

 
%controllo che le due implementazioni sono equivalenti
diff = yv - y;
err = sum(diff) / length(diff);
%OK!