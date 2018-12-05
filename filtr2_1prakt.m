% projektowanie filtru cyfrowego FIR LP
% metoda probkowania w dziedziwnie czestotliwosci
% okno=0 -bez okna(okno prostokatne); okno=1 okno Blackmana
% zielisnki str 308
%% Zadanie domowe
%% wymnozyc h(n) przez okno blackmana i powtorzyc obliczenia
%% funkcji transmitancji dla zokienkowanej odp. impulsowej


%% zastosowanie funkcji okna dla odpowiedzi impulsowej
%%h=h.*blackman(N)';

clf; clear all; subplot(1,1,1)
N=33; % dlugosc odpowiedzi impulsowej
% odpowiedz impulsowa symetryczna - Typ I
okno=0; % bez okna czyli okno prostokatne
% okno=1

M=(N-1)/2;
M2=M/2;     % 0.25 rzedu filtru
z2=zeros(1,M2); j2=ones(1,M2);

% tworzenie charakterystyki czestotliwosciowej idealnego filtru FIR
  Ar=[1 j2 z2 z2 j2]; % czesc rzeczywista idealnej char. czestotliwosciowej
  Ai=zeros(1,N);      % czesc urojona
  A=Ar+j*Ai;          % zespolona funkcja transmitancji

 % obliczenie IDFT{A} ===>> h(n)
 n=0:(N-1);
 f=n/N;     % czestotliwosc unormowana
 h=zeros(1,N);
 for k=0:N-1
  % (n-M) - przesuniecie kolowe o M probek w prawo
  h=h+A(k+1)*exp(j*2*pi*k/N*(n-M));
 endfor
 
 subplot(3,2,1);
 stem((n-M),h,'.'); grid on;
 title("Odpowiedz impulsowa h(n)");
 
% ====== liczenie DFT z h(n)
NF=1000;  % liczba probek f transmitancji filtru
k=0:NF-1; % indeksy dla kolejnych czestotliwosci
fn=k/NF;

for k=0:NF-1
  H(k+1)=exp(-j*2*pi*k/NF*(n-N))*h';
endfor

% niedokladnosc float moze wytworzyc zamiast zespolonych zer liczby
% bardzo bliskie zeru, ale jak beda to nie da sie wykreslic
H=H/N;
Hx=real(H);

subplot(3,2,3);
stem(f,Ar,'r.'); grid on;
hold on;
plot(fn,abs(H),'b');
%plot(f,Ar,'r',fn,abs(H),'b'); grid on;
title('Charakterystyki ampl. filtru: idealna i faktyczna');
legend('idealna','faktyczna');

% transmitancja w skali decybelowej
subplot(3,2,5);
plot(fn,20*log10(abs(H))); grid on;
title('abs(H) w [dB]');

% =========== Sygnal z oknem blackmana =========== %
% odpowiedz impulsowa h(n) przemnozona przez okno blackmana
subplot(3,2,2);
h=h.*blackman(N)'; % Ten sam sygnal, tylko zokienkowany
stem((n-M),h,'.'); grid on;
title("Odpowiedz impulsowa pomnozona przez okno blackmana h(n)");

% Wyznaczenie transmitancji na nowo
H = [];
for k=0:NF-1
  H(k+1)=exp(-j*2*pi*k/NF*(n-N))*h';
endfor

% niedokladnosc float moze wytworzyc zamiast zespolonych zer liczby
% bardzo bliskie zeru, ale jak beda to nie da sie wykreslic
H=H/N;
Hx=real(H);

subplot(3,2,4);
stem(f,Ar,'r.'); grid on;
hold on;
plot(fn,abs(H),'b');
title('Charakterystyki ampl. filtru: idealna i faktyczna');
legend('idealna','faktyczna - blackman');

% Transmitancja w skali decybelowej
subplot(3,2,6);
plot(fn,20*log10(abs(H))); grid on;
title('abs(H) w [dB]');







