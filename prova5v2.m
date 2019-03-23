clear all
close all

% PROVA DELLA CASCATA DI DUE FUNZIONE5 UNA IN MODALITA L E L'ALTRA 
% IN MODALITA H IMPLEMETATE DA ME CON SPECTROGRAMMA

% paramtri da settare ..........................

k=0.95;         %parametro circuito -> ]0,1[
Npoli =  8;     %numero poli(=zeri) all-pass (pari)
M = 0.96;       %modulo poli

%................................................

[b,a] = myAllPass(Npoli,M); %progetto filtro all-pass
%figure;zplane(b,a); title('poli e zeri all-pass')


% Segnale ingresso
[x,fs] = audioread('Rumore_bianco.wav');
%x(:,1) = []; %se segnale stereo
x = x';

y1 = funzione5(x,'L',b,a,k);
y = funzione5(y1,'H',b,a,k);

figure
spectrogram(x,512,256,512);
caxis( [-120 -20] ) %blocca i colori nello spettro di potenza
title('segnale ingresso');

figure
spectrogram(y,512,256,512);
caxis( [-120 -20] )
title('segnale uscita');