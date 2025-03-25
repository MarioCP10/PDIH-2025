void setup() {
  pinMode(7, INPUT);
  pinMode(13, OUTPUT);
}

void loop() {
  if (digitalRead(7) == HIGH) {
    digitalWrite(13, HIGH);
  } else {
    digitalWrite(13, LOW);
    delay (1000);
  }
  delay(10); //Hacemos un pequeño retraso
}
