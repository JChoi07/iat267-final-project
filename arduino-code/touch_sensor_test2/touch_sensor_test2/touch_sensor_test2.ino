#include <Wire.h>
#include <i2c_touch_sensor.h>
#include <MPR121.h>

int ledBlue = 8;
int ledRed = 9;
int ledGreen = 10;
int ledYellow = 11;

i2ctouchsensor touchsensor;
float myVariable;

uint8_t getTouchSensorValue() {
  touchsensor.getTouchState();
  while(1)  {
    touchsensor.getTouchState();
    for (int i=0;i<12;i++) {
      if (touchsensor.touched&(1<<i)) {
        return i;
        delay(100);
      }
      if (!touchsensor.touched&(1<<i)) {
        return 13;
      }
    }
  }
}

void setup(){
  Wire.begin();
  touchsensor.initialize();
  Serial.begin(9600);

  pinMode(ledBlue, OUTPUT);
  pinMode(ledRed, OUTPUT);
  pinMode(ledGreen, OUTPUT);
  pinMode(ledYellow, OUTPUT);
}



void loop(){

  if (getTouchSensorValue() == 8) {
    Serial.println("pin 8 was touched");
    digitalWrite(ledBlue, HIGH);
  }
  if (getTouchSensorValue() != 8) {
    digitalWrite(ledBlue, LOW);
  }
  if (getTouchSensorValue() == 9) {
    Serial.println("pin 9 was touched");
    digitalWrite(ledRed, HIGH);
  }
  if (getTouchSensorValue() != 9) {
    digitalWrite(ledRed, LOW);
  }
  if (getTouchSensorValue() == 10) {
    Serial.println("pin 10 was touched");
    digitalWrite(ledGreen, HIGH);
  }
   if (getTouchSensorValue() != 10) {
    digitalWrite(ledGreen, LOW);
  }
  if (getTouchSensorValue() == 11) {
    Serial.println("pin 11 was touched");
    digitalWrite(ledYellow, HIGH);
  }
  if (getTouchSensorValue() != 11) {
    digitalWrite(ledYellow, LOW);
  }

//  Serial.println(getTouchSensorValue());
}
