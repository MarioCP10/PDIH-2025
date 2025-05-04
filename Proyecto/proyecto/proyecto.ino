#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <Servo.h>

LiquidCrystal_I2C lcd_1(0x27, 16, 2);
Servo servoMotor;  
Servo servoMotor2;  

const int pinTrigger   = 2;
const int pinEcho      = 3;
const int pinTrigger2  = 4;
const int pinEcho2     = 5;
const int ledRojo      = 6;
const int ledVerde     = 7;
const int pulsador     = 12; 
const int pinPiezo     = 11; 
const int pulsadorE    = 8;  

const int pinTemp = A0;

float tiempo = 0;
float distancia = 0;
float tiempo2 = 0;
float distancia2 = 0;

int conta = 0;
const int totalPlazas = 5;

int sensorValue = 0;
float temperatura = 0;  

unsigned long tiempoUltimaEntrada = 0;
unsigned long tiempoUltimaSalida = 0;
const unsigned long retardoAntirrebote = 500;
unsigned long ultimaActualizacionPantalla = 0;
const unsigned long intervaloPantalla = 100;

int estadoEntrada = 0;
bool salidaActivada = false;

void setup() {
  Serial.begin(9600);
  Serial.println("Sistema iniciado...");

  Wire.begin();
  lcd_1.init();
  lcd_1.backlight();
  lcd_1.clear();
  lcd_1.setCursor(0, 0);
  lcd_1.print("P: ");
  lcd_1.setCursor(8, 0);
  lcd_1.print("T: ");
  lcd_1.setCursor(0, 1);
  lcd_1.print("                ");

  pinMode(pinTrigger, OUTPUT);
  pinMode(pinEcho, INPUT);
  pinMode(pinTrigger2, OUTPUT);
  pinMode(pinEcho2, INPUT);

  servoMotor.attach(9);
  servoMotor.write(0);

  servoMotor2.attach(10);
  servoMotor2.write(0);

  pinMode(ledRojo, OUTPUT);
  pinMode(ledVerde, OUTPUT);
  digitalWrite(ledRojo, HIGH);
  digitalWrite(ledVerde, LOW);

  pinMode(pulsador, INPUT_PULLUP);
  pinMode(pulsadorE, INPUT_PULLUP);
  pinMode(pinPiezo, OUTPUT);
}


void loop() {
  unsigned long milis = millis();

  //Primer paso: lectura del sensor de temperatura
  sensorValue = analogRead(pinTemp);
  float voltaje = sensorValue * (5.0 / 1023.0); 
  temperatura = (voltaje - 0.5) * 50.0;
  temperatura = 16.0 + (((sin(millis() / 2000.0) + 1.0) / 2.0) * 7.0);



  //Segundo paso: lectura del sensor ultrasónico de entrada
  digitalWrite(pinTrigger, LOW);
  delayMicroseconds(4);
  digitalWrite(pinTrigger, HIGH);
  delayMicroseconds(10);
  digitalWrite(pinTrigger, LOW);
  tiempo = pulseIn(pinEcho, HIGH);
  distancia = 0.0172 * tiempo;

  //Tercer paso: lectura del sensor ultrasónico de salida
  digitalWrite(pinTrigger2, LOW);
  delayMicroseconds(4);
  digitalWrite(pinTrigger2, HIGH);
  delayMicroseconds(10);
  digitalWrite(pinTrigger2, LOW);
  tiempo2 = pulseIn(pinEcho2, HIGH);
  distancia2 = 0.0172 * tiempo2;

  // Cuarto paso: control de la puerta de entrada
  if (temperatura > 30) {
    tone(pinPiezo, 4000);
    lcd_1.setCursor(0, 1);
    lcd_1.print("INCENDIO       ");
    servoMotor.write(0);
    servoMotor2.write(90);
  } 
  else if (conta < totalPlazas) {
    if (distancia <= 30) {
      if (estadoEntrada == 0) {
        estadoEntrada = 1;
      }
      if (estadoEntrada == 1) {
        lcd_1.setCursor(0, 1);
        lcd_1.print("PULSE BOTON    ");
        if (digitalRead(pulsadorE) == HIGH && (millis() - tiempoUltimaEntrada >= retardoAntirrebote)) {
          estadoEntrada = 2;
          tiempoUltimaEntrada = millis();
        }
        servoMotor.write(0);
      }
      if (estadoEntrada == 2) {
        lcd_1.setCursor(0, 1);
        lcd_1.print("BIENVENIDO     ");
        servoMotor.write(90);
        digitalWrite(ledRojo, LOW);
        digitalWrite(ledVerde, HIGH);
        delay(2000);
        conta++;
        servoMotor.write(0);
        digitalWrite(ledRojo, HIGH);
        digitalWrite(ledVerde, LOW);
        estadoEntrada = 0;
      }
    }
    else {
      estadoEntrada = 0;
      servoMotor.write(0);
    }
  } 
  else {
    servoMotor.write(0);
  }

  //Quinto paso: control de la puerta de salida
  if (temperatura > 30) {
    tone(pinPiezo, 4000);
    servoMotor2.write(90);
    if (distancia2 <= 30 && !salidaActivada && (milis - tiempoUltimaSalida >= retardoAntirrebote)) {
      if (conta > 0) { conta--; }
      salidaActivada = true;
      tiempoUltimaSalida = milis;
    }
    else if (distancia2 > 30) {
      salidaActivada = false;
    }
  }
  else {
    if (distancia2 < 30 && digitalRead(pulsador) == HIGH) {
      servoMotor2.write(90);
      delay(3000);
      if (!salidaActivada && (milis - tiempoUltimaSalida >= retardoAntirrebote)) {
        if (conta > 0) { conta--; }
        salidaActivada = true;
        tiempoUltimaSalida = milis;
      }
      servoMotor2.write(0);
    }
    else {
      digitalWrite(pinPiezo, LOW);
      servoMotor2.write(0);
      salidaActivada = false;
    }
  }

  //Sexto paso: actualización del LCD donde mostraremos el num de plazas disponibles y la temperatura
  if (milis - ultimaActualizacionPantalla >= intervaloPantalla) {
    ultimaActualizacionPantalla = milis;
    int plazasLibres = totalPlazas - conta;
    lcd_1.setCursor(0, 0);
    lcd_1.print("P:");
    if (plazasLibres < 10) { lcd_1.print(" "); }
    lcd_1.print(plazasLibres);
    lcd_1.print("  ");
    lcd_1.setCursor(8, 0);
    lcd_1.print("T:");
    lcd_1.setCursor(11, 0);
    char tempBuffer[6];
    dtostrf(temperatura, 5, 1, tempBuffer);
    lcd_1.print(tempBuffer);

    if (estadoEntrada == 0) {
      lcd_1.setCursor(0, 1);
      if (temperatura > 30) {
        lcd_1.print("INCENDIO       ");
        servoMotor2.write(90);
      }
      else if (plazasLibres == 0) {
        lcd_1.print("Parking Completo");
      }
      else {
        lcd_1.print("                ");
      }
    }
  }

  Serial.print("Temp: ");
  Serial.print(temperatura);
  Serial.print(" C, Free Spots: ");
  Serial.println(totalPlazas - conta);
}
