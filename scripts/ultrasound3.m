% ULTRASOUND3 programa para capturar datos por el puerto serial. Previo a
% ejecutar el programa verifique mediante el Administrador de dispositivos
% el puerto alque est� conectado el ARDUINO y modifique el n�mero de puerto 
% en la instrucci�n PORT. Ricardo % Ram�rez Heredia, Universidad Nacional 
% de Colombia, 2023. 

clear all;
port=serialport('/dev/cu.usbserial-1130',9600,'DataBits',8);
flush(port)
nm=100; %N�mero de muestras.
figure(1)
clf
xlabel('Muestra')
ylabel('Distancia (cm)')
title('U_{sound} Data')
grid on;
hold on;
t=1:nm;
dist=zeros(1,nm);
for i=1:nm
      dist(i)=readline(port); 
      pause(.25)
end
plot(t,dist)
delete(port);
clear port

writematrix(dist,'data1.csv') 