%plik zera_bieguny.m

% IIR filter design; metoda zer i biegonow

clear all;clf;subplot(1,1,1);
fs=1000; % f probkowania

% zera i bieguny tranmitnacji H(z)

fz=[50]; % czestotliowsc zera
fp = [10]; % czes bieguna
Rz =[1]; % modul dla zera
Rp=[0.96]; % modul dla bieguna
fmax=100;df=0.1; % parmetry dla transformaty Furiera

% zeposolone wartosci ze i biegunow
fi_z= 2*pi*fz/fs;  % katy dla zera
fi_p =2*pi*fp/fs;  % katy dla biegunow
z=Rz.*exp(j*fi_z); % zero w gornej polpaszczyznie
p=Rp.*exp(j*fi_p); % bieguny w gornej polplaszczynie
z=[z conj(z)]; % zero + zero sprzezone
p=[p conj(p)]; % bieguny + bieguny sprzezone

% zera i bieguny na plaszczyznie z (wykres)

NP = 1000;
fi=2*pi*(0:NP-1)/NP;
s = sin(fi);c =cos(fi);
%zplane(z',p')
subplot(3,2,1)
plot(s,c,'-k',real(z),imag(z),'or',real(p),imag(p),'xb');
title('Zeros and poles of frequency response');

%obliczenie wspolczynikow {a} {b}
wzm = 1;
[b,a]=zp2tf(z',p',wzm);

% obliczenie funkcji tranmitancji ({b,a} -> H(f) )
f=0:df:fmax;
w=2*pi*f;   %pulsacja
wn= 2*pi*f/fs;  % pulsacja znormalizowana

H=freqz(b,a,wn);
Habs=abs(H);
HdB=20*log10(Habs);
Hfa = unwrap(angle(H));

subplot(3,2,3)
plot(f,Habs); grid on; xlabel('f[Hz]');
title('Charakterystyka amplitudowa |H(f)| ')

subplot(3,2,5)
plot(f,Hfa);grid on; title('Kat H(f)');xlabel('f[Hz]');ylabel('[rad]');
title('Charakterystyka fazowa |H(f)| ')

% ===============================================
% Zadanie domowe
% Zaprojektowac filtr IIR z parametrami ponizej.
% Rzad filtru = 10
% Czestotliwosc graniczna = 60 Hz
% Czestotliwosc próbkowania = 600
% Liczba próbek = 1200
% ================================================

filter_order = 10;     % rzad filtru
freq_cutoff = 60;      % czestotliwosc graniczna
freq_samp=600;         % czestotilowsc probkowania
sample_count = 1200;   % liczba probek

[b,a] = butter(filter_order,freq_cutoff/(freq_samp/2) );
f = 0:df:freq_samp;
wn = 2*pi*f/freq_samp;  % pulsacja znormalizowana
H = freqz(b,a,wn);
Habs = abs(H);
Hfa = unwrap(angle(H));

subplot(3,2,4)
plot(f,Habs ); grid on; xlabel('f[Hz]');
title('Charakterystyka amplitudowa butterworth |H(f)| ')

subplot(3,2,6)
plot(f,Hfa);grid on; title('Kat H(f)');xlabel('f[Hz]');ylabel('[rad]');
title('Charakterystyka fazowa butterworth |H(f)| ')

