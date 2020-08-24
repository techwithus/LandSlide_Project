#include <SimpleDHT.h>
int pinDHT22 = 8;
SimpleDHT22 dht22(pinDHT22);
int Analogue0 = 0; // first analog sensor
int Analogue1 = 0; // second analog sensor
int Analogue2 = 0; // digital sensor
int Analogue3 = 0; // second analog sensor
int Analogue4 = 0; // second analog sensor
int Analogue5 = 0; // second analog sensor
int inByte = 0; // incoming serial byte
void setup()
{
 // start serial port at 9600 bps:
 Serial.begin(9600);
 pinMode(10,INPUT);
//establishContact(); // send a byte to establish contact until Processing responds 
}
void loop()
{float temperature = 0;
  float humidity = 0;
  long vibrationMeasurement = TP_init(10);
int err = SimpleDHTErrSuccess,tempData,humiData;
  if ((err = dht22.read2(&temperature, &humidity, NULL)) != SimpleDHTErrSuccess) {
    
    return;
  }
  tempData = temperature*100;
  humiData = humidity*100;
 // if we get a valid byte, read analog ins:
//if (Serial.available() > 0) {
 // get incoming byte:
// inByte = Serial.read();
 // read first analog input, divide by 4 to make the range 0-255:
 Analogue0 = analogRead(0);
 // delay 10ms to let the ADC recover:
 delay(10);
 // read second analog input, divide by 4 to make the range 0-255:
 Analogue1 = analogRead(1);
 // read switch, multiply by 155 and add 100
 // so that you're sending 100 or 255:
 delay(10);
 Analogue2 = analogRead(2);
 delay(10);
 Analogue3 = analogRead(3);
 delay(10);
 Analogue4 = analogRead(4);
 delay(10);
 Analogue5 = analogRead(5);
 delay(10);
// send sensor values:
 /*Serial.write( int( 100 - ( (Analogue0/1023.00) * 100 ) ));
 Serial.write(int( 100 - ( (Analogue1/1023.00) * 100 ) ) );
 Serial.write( int( 100 - ( (Analogue2/1023.00) * 100 ) ));
 Serial.write(int( 100 - ( (Analogue3/1023.00) * 100 ) ));
 Serial.write(int( 100 - ( (Analogue4/1023.00) * 100 ) ) );
 //Serial.write(Analogue5 );*/
 Serial.println(String(Analogue0)+","+String(Analogue1)+","+String(Analogue2)+","+String(Analogue3)+","+String(Analogue4)+","+String(vibrationMeasurement)+","+String(int(tempData))+","+String(int(humiData))+",");
 //}
}
void establishContact() {
 while (Serial.available() <= 0) {
 Serial.write('A'); // send a capital A
 delay(300);
 }
}

long TP_init(int pinNumber){
  delay(10);
  long measurement=pulseIn (pinNumber, LOW);  //wait for the pin to get HIGH and returns measurement
  return measurement;
}
