void setup() {
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
}

void loop() {
  digitalWrite(13, HIGH);
  digitalWrite(12, LOW);
  delay(1500); //Esperamos 1500ms (1.5s) 
  digitalWrite(13, LOW);
  digitalWrite(12, HIGH);
  delay(1500); //Esperamos 1500ms (1.5s)
}
