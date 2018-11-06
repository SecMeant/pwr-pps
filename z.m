% f(x) = A*sin(2*pi*f*t)
rangeFrom = 0;
rangeTo = 1;
step = 0.0001;
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

plot(t,y1+y2);
grid on;
