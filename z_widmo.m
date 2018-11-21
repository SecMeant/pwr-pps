% f(t) = A*sin(2*pi*f*t)
rangeFrom = 0;
rangeTo = 1;
fs = 1000;
step = 1/fs;
t = rangeFrom:step:rangeTo-step;

% Pierwszy sygnal - sin(x)
f1 = 2;
A1 = 1;
y1 = A1 * sin(2*pi*f1*t);

% Drugi sygnal - prostokatny
f2 = 10;
A2 = 1;

% Wytwarzanie jednego okresu
okres = ones(1,columns(t)/f2/2);
okres = [okres, zeros(1,columns(t)/f2/2)];

% Pusty sygnal
y2 = [];

% Dla kazdego okresu doklej go do sygnalu
for i = 1:f2
  y2 = [y2, okres];
endfor

% narysuj sygnal pierszy w pierwszym wierszu
subplot(3,1,1);
plot(t,y1);

% drugi sygnal w drugim wierszu
subplot(3,1,2);
plot(t,y2);

% trzeci sygnal w trzecim wierszu
subplot(3,1,3);
ysum = y1+y2;
plot(t,ysum);

% stworz nowe okno dla widm sygnalow
figure

widmo_t = 0:fs-1;
% narysuj widmo sygnalu pierszego w pierwszym wierszu
subplot(3,1,1);
y1_widmo = fft(y1);
y1_widmo = abs(y1_widmo);     % obliczenie wartosci bezwzglednej dla widma
y1_widmo = y1_widmo / (fs/2); % podziel amplitude przez polowe ilosc probek
plot(widmo_t,y1_widmo);

% opis osi dla sygnalu 1
title("Widmo sygnalu 1");
xlabel("Czestotliwosc [Hz]");
ylabel("Amplituda");

% widmo drugiego sygnalu w drugim wierszu
subplot(3,1,2);
y2_widmo = abs(fft(y2));
y2_widmo = abs(y2_widmo);     % obliczenie wartosci bezwzglednej dla widma
y2_widmo = y2_widmo / (fs/2); % podziel amplitude przez polowe ilosc probek
plot(widmo_t,y2_widmo);

% opis osi dla sygnalu 2
title("Widmo sygnalu 2");
xlabel("Czestotliwosc [Hz]");
ylabel("Amplituda");

% widmo trzeciego sygnalu w trzecim wierszu
subplot(3,1,3);
ysum_widmo = fft(ysum);
ysum_widmo = abs(ysum_widmo);     % obliczenie wartosci bezwzglednej dla widma
ysum_widmo = ysum_widmo / (fs/2); % podziel amplitude przez polowe ilosc probek
plot(widmo_t,ysum_widmo);

% opis osi dla sygnlu 3
title("Widmo sygnalu 3");
xlabel("Czestotliwosc [Hz]");
ylabel("Amplituda");

% wlacz siatke na wykresach
grid on;
