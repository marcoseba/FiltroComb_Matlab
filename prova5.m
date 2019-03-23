% prova funzione5
clear all
close all

% paramtri da settare ..........................

k=0.95;         %parametro circuito -> ]0,1[
Npoli =  8;     %numero poli(=zeri) all-pass (pari)
M = 0.96;       %modulo poli
flag = 'H';     %modo operativa H oppure L

%................................................

[b,a] = myAllPass(Npoli,M); %progetto filtro all-pass
figure;zplane(b,a); title('poli e zeri all-pass')

%verifico l'equivalenza dell mia implementazione e usando filter

x =rand(10000,1); %segnale prova random
y1 = funzione5(x,flag,b,a,k);
y2 = funzione5v2(x,flag,b,a,k);
diff = y2 - y1;
err = sum(diff)/length(diff);  %errore

% CONSIDERAZIONI SULL EFFICIENZA
% per l'implementazione della parte zeri si eseguono Nb prodotti 
% e Nb somme, dove Nb è la lunghezza del vettore b quindi dipende 
% del numero di poli.
% per l'implementazion della parte poli si eseguono Na prodotti e
% Na+1 somme. dove Na è la lunghezza del vettore a uguale al vettore b
% In totale se N è il nuemro di poli per ogni campione si avranno
% 2N+1 somme e 2N prodotti


% DISEGNO DIAGRAMMI MODULO E FASE 

% passare dalla funzione A(z)(all-pass) alla funzione 
% H(z) (f.d.t. complessiva) circuto primo punto

% A(z) = b/a  --> Hsomma(z) = Bsomma/A , Hdiff(z) = Bdiff/A

A = a;
Bsomma = a*(1+k/2) + k/2*b; 
Bdiff = a*(1-k/2) + k/2*b;

figure;freqz(Bsomma,A); title('funzione somma')
figure;freqz(Bdiff,A);  title('funzione differenza')

% cascata una funzione somma e una differenza
Atot = conv(A,A);
Btot = conv(Bsomma,Bdiff);
figure;freqz(Btot,Atot); title('cascata')


