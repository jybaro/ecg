int sensorValue = 0;      
int outputValue = 0;  
void setup() {
  // inicializacion de serial
  Serial.begin(9600);
  pinMode(10, INPUT); //Deteccion de LO+
  pinMode(11, INPUT); // Deteccion de LO-
  

}

void loop() {
  
  if((digitalRead(10) == 1)||(digitalRead(11) == 1)){
    Serial.println('!');
  }
  else{
 //Leer valor analogo
  
        Serial.println(analogRead(A0));
  }
//Tiempo de espera
  delay(1);
}
