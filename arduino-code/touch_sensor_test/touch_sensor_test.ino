/*
  I2C-Multi-Touch-Sensor-Grove
  modified on 18 oct 2020
  by Amir Mohammad Shojaee @ Electropeak
  https://electropeak.com/learn/

  Based on wiki.seeedstudio.com Example
*/

#include <Wire.h> // include I2C library
#include <defs.h>
#include <i2c.h>
#include <i2c_touch_sensor.h>
#include <mpr121.h>
#include <types.h>
#include <MPR121.h>
// include our Grove I2C touch sensor library
// initialize the Grove I2C touch sensor

i2ctouchsensor touchsensor; // keep track of 4 pads' states
//boolean padTouched[4];
int led = 8;
long previousMillis = 0;
long interval = 100;
void setup()  {    
    Serial.begin(9600); // for debugging   
    Serial.print("begin to init");  
    Wire.begin(); // needed by the GroveMultiTouch lib     
    touchsensor.initialize(); // initialize the feelers     // initialize the containers     

    pinMode(led, OUTPUT);
  }
void loop() {     
 unsigned char MPR_Query=0;
 unsigned long currentMillis = millis();
 
 if(currentMillis - previousMillis > interval)  {
    previousMillis = currentMillis;
    touchsensor.getTouchState();
 }
  
 for (int i=0;i<12;i++) {
   if (touchsensor.touched&(1<<i))  {
    Serial.print("pin ");
          Serial.print(i);
          Serial.println(" was  touched");
          delay(100);
//     switch(i)  {
//      case 10:
//        digitalWrite(led, HIGH);
//        break;
//
//      default:
//        digitalWrite(led, LOW);
//        break;
//     }
    }
    if (i == 10) {
      digitalWrite(led, HIGH);
    }
    else{
      digitalWrite(led, LOW);
    }
 }
}
