%verifico che la funzione 1 stia lavorando correttamente
%confrontado la sua uscita e una calcolata implementando direttemnte
%il circuito in figura

clear all 
close all

%segnale ingresso
x=0.4*rand(10000,1); % Additive white Gaussian noise 

%parametri da impostare
r = 0.1;  %[0,0.5];
k = 0.99;  %[0,1]; non sicuro!
flag = 'H';  %sceglier H oppure L

fs = 48000;
fc = r*fs;

%uscita mia implementazione
y = funzione1(x,flag,fc,fs,k);

%prova con implementzione diretta del circuito (usando all pass)
y2 = funzione1v2(x,flag,fc,fs,k);

%verifica che le due implementazione siano equivalenti
diff = y2' - y;
err = sum(diff)/length(diff);
%ok !! errore e quasi nullo!
