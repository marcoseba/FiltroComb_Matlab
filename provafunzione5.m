clear all
close all

M1=0.95;  
fc=0.2;
beta1=pi*fc;  % con fc=]0,1[  sposta la frequenza di taglio 

b1=[M1^2 -M1*exp(1i*beta1)-M1*exp(-1i*beta1) 1];
a1=[1,-M1*exp(-1i*beta1)-M1*exp(1i*beta1), M1^2];

M2=0.95;  
fc=0.3;
beta2=pi*fc;  % con fc=]0,1[  sposta la frequenza di taglio 

b2=[M2^2 -M2*exp(1i*beta2)-M2*exp(-1i*beta2) 1];
a2=[1,-M2*exp(-1i*beta2)-M2*exp(1i*beta2), M2^2];

b=conv(b1,b2);
a=conv(a1,a2);

figure; zplane(b,a); title('poli e zeri all-pass')
figure; freqz(b,a); title('f.d.t. all-pass')


%passare dalla funzione A(z) alla funzione H(z) circuto primo punto

% A(z) = b/a  --> Hsomma(z) = Bsomma/A , Hdiff(z) = Bdiff/A

k=0.8;

A = a;
Bsomma = a*(1+k/2) + k/2*b; 
Bdiff = a*(1-k/2) + k/2*b;

figure;freqz(Bsomma,A); title('funzione somma')
figure;freqz(Bdiff,A);  title('funzione differenza')

%cascata una funzione somma e una differenza

Atot = conv(A,A);
Btot = conv(Bsomma,Bdiff);
figure;freqz(Btot,Atot); title('cascata')




