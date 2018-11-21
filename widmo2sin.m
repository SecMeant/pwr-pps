% widmo amplitudowe dla sumy
% 2 sygnalow sinusoidalnych

clear all; clf;
fs = 2000;      % Czestotliwosc probkowania
N  = 1000;      % Liczba probek
%f1 = 140;       % Czestotliwosci skladowe
%f2 = 350;
f1 = 140.2;
f2 = 352;
A1 = 2;         % amplitudy sinusoid
A2 = 1;
Ts = 1/fs;      % okres probkowania
t  = 0:Ts:(N-1)*Ts; % wektor czasu

x1 = A1*sin(2*pi*f1*t); % sygnal 1
x2 = A2*sin(2*pi*f2*t); % sygnal 2

x = x1+x2; % suma sygnalow
szum = randn(1,length(x)); % szum gaussowski
x = x + szum;

subplot(2,1,1);
plot(t,x);
xlabel("Czas [s]");
title("Suma sugnalow");
grid on;

X  = fft(x); % DFT
Xa = abs(X); % charakterystyka amplitudowa (modul X)

df = fs/N       % rozdzielczosc widma
f = 0:df:fs-df; % wektor czestotliwosci
subplot(2,1,2);
stem(f,Xa,".");
xlabel("Czestotliwosc [Hz]");
title("Widmo amplitudowe sygnalu");

figure 
stem(f(1:N/4),Xa(1:N/4),".");
xlabel("Czestotliwosc [Hz]");
title("Widmo amplitudowe sygnalu");

