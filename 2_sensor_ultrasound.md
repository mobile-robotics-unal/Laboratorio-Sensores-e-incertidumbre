# Preparation
Después de *verificar* y *cargar* el código en el *Arduino UNO*. Es necesario asegurarse que el *serial port* en el *Administrador de Dispositivos* (Windows) corresponda al *serial port* asociado a la placa Arduino. Luego, abrimos *Arduino IDE* y el archivo *usound3.ino* y verificamos que los pines asociados en el código al disparador y al eco sean los mismos que los de la *Placa Arduino*. En la siguiente imagen, el lector puede ver la conexión de pines en la placa *Arduino UNO*.

<p align="center">
  <img align="center" height="200" src="https://github.com/mobile-robotics-unal/Sensors-and-uncertainty/assets/161974694/8d69556e-cf93-4ae9-81aa-564f9e70dbac">
<p/>

Usando el siguiente código desarrollado por los profesores *Dr.Ing. Ricardo Ramírez* y *PhD. Ing. Pedro Cárdenas*, verificamos y subimos el código a la placa Arduino. Como una verificación del rendimiento del código, se abre el *serial monitor* en *ARduino IDE* y podemos verificar en la lectura de los valores de distancia en centímetros.
```c++
// declaración de variables para pines
const int pinecho = 11;
const int pintrigger = 12;
 
// variables para calculos
unsigned long tiempo;
float distancia;
 
/**
   Función setup: se ejecuta una vez cuando encendemos el arduino
*/
void setup()
{
  // preparar la comunicación serial
  Serial.begin(9600);
 
  // configurar los pines utilizados por el sensor
  pinMode(pinecho, INPUT);
  pinMode(pintrigger, OUTPUT);
 
 }
 
/**
   Función loop: se ejecuta continuamente mientras el arduino permanece encendido
*/
void loop()
{
  // asegurarnos que el pin trigger se encuentra en estado bajo
  digitalWrite(pintrigger, LOW);
  delayMicroseconds(2);
 
  // comenzamos pulso alto, debe durar 10 uS
  // luego regresamos a estado bajo
  digitalWrite(pintrigger, HIGH);
  delayMicroseconds(10);
  digitalWrite(pintrigger, LOW);
 
  // medimos el tiempo en estado alto del pin "echo"
  // el tiempo en estado alto es proporcional a la distancia medida
  tiempo = pulseIn(pinecho, HIGH);
 
  // LA VELOCIDAD DEL SONIDO ES DE 340 M/S O 29,4 MICROSEGUNDOS POR CENTIMETRO
  // DIVIDIMOS EL TIEMPO DEL PULSO ENTRE 58, TIEMPO QUE TARDA RECORRER IDA Y
  // VUELTA UN CENTIMETRO LA ONDA SONORA
  distancia = float(tiempo) / 58.8;
 
  // imprimir la distancia medida al monitor serial
  //Serial.print(F("Distancia: "));
 Serial.print(distancia);
 Serial.print('\n');
 // Serial.println(F(" cm"));
 
  // esperar 0,25 segundos antes de realizar otra medición
  delay(250);
}
```
Output in the serial monitor:
<p align="center">
  <img align="center" height="200" src="https://github.com/mobile-robotics-unal/Sensors-and-uncertainty/assets/161974694/78bee725-33b4-4578-ad09-988821918a82">
<p/>

Then, to obtain the experimental data for each distance between *1 to 2.5 m*, we run the *ultrasound3.m* file in *MATLAB R2024a*. However, to avoid problems with the connection, is necessary modify the numper of the port in the *serialport()* command and close *Arduino IDE*, otherwise *MATLAB* will show an error.
Posteriormente, para poder obbtener los datos experimentales de un conjunto de 100 mediciones para distancias entre *1 a 2.5 m*, corremos el programa *ultrasound3.m* file in *MATLAB R2024a*. Sin embargo, para evitar problemas con la conexión, es neccesario modificar el número del *serialport()* command and close *Arduino IDE*, de lo contrario *MATLAB* arrojará un error.
```matlab
% ULTRASOUND3 programa para capturar datos por el puerto serial. Previo a
% ejecutar el programa verifique mediante el Administrador de dispositivos
% el puerto alque está conectado el ARDUINO y modifique el número de puerto 
% en la instrucción PORT. Ricardo % Ramírez Heredia, Universidad Nacional 
% de Colombia, 2023. 

clear all;
port=serialport("COM7",9600,"DataBits",8);
flush(port)
nm=100; %Número de muestras.
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
```
In the next figure, there is an example of the processed data for a distance of *5 cm*. 
<p align="center">
  <img align="center" height="200" src="https://github.com/mobile-robotics-unal/Sensors-and-uncertainty/assets/161974694/ae1908d0-491c-4921-9dab-d32a32dd899e">
  <img align="center" height="200" src="https://github.com/mobile-robotics-unal/Sensors-and-uncertainty/assets/161974694/391b45c4-43d4-4867-8c34-0dcccd1861a9">
<p/>
# Resultados.

# References
1. Ramírez, Ricardo and Cárdenas, Pedro. _Laboratorio 2 Evaluación de incertidumbre de un sensor_. Fundamentos de robótica móvil. Departamento de Ingeniería Mecánica y Mecatrónica. Universidad Nacional de Colombia. Bogotá, Colombia, 2024.
2. Ramírez, Ricardo and Cárdenas, Pedro. _Sensores e incertidumbre_. Fundamentos de robótica móvil. Departamento de Ingeniería Mecánica y Mecatrónica. Universidad Nacional de Colombia. Bogotá, Colombia, 2024.
3. https://howtomechatronics.com/tutorials/arduino/ultrasonic-sensor-hc-sr04/
4. https://naylampmechatronics.com/blog/10_tutorial-de-arduino-y-sensor-ultrasonico-hc-sr04.html
5. https://www.luisllamas.es/medir-distancia-con-arduino-y-sensor-de-ultrasonidos-hc-sr04/
