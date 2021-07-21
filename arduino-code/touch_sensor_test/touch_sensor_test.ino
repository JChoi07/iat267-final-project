/*
  I2C-Multi-Touch-Sensor-Grove
  modified on 18 oct 2020
  by Amir Mohammad Shojaee @ Electropeak
  https://electropeak.com/learn/

  Based on wiki.seeedstudio.com Example
*/

// include our Grove I2C touch sensor library
// initialize the Grove I2C touch sensor
#include <Wire.h> // include I2C library
#include <defs.h>
#include <i2c.h>
#include <i2c_touch_sensor.h>
#include <mpr121.h>
#include <types.h>

//set fields
i2ctouchsensor touchsensor; // keep track of 4 pads' states
long previousMillis = 0;
long interval = 100;

int ledBlue = 8;
int ledRed = 9;
int ledGreen = 10;
int ledYellow = 11;

int touchSensorValue = 13;


void setup()  {    
    Serial.begin(9600); // for debugging   
    Serial.print("begin to init");  
    Wire.begin(); // needed by the GroveMultiTouch lib     
    touchsensor.initialize(); // initialize the feelers     // initialize the containers     

    pinMode(ledBlue, OUTPUT);
    pinMode(ledRed, OUTPUT);
    pinMode(ledGreen, OUTPUT);
    pinMode(ledYellow, OUTPUT);
  }
  
void loop() {     
 unsigned char MPR_Query=0;
 unsigned long currentMillis = millis();
 
 if(currentMillis - previousMillis > interval)  {
    previousMillis = currentMillis;
    touchsensor.getTouchState();
 }

 for (int i=0;i<12;i++) {
    if (touchsensor.touched&(1<<i))  {             //check if touch sensor is being touched
      Serial.print("pin ");
      Serial.print(i);
      Serial.println(" was  touched");
//      delay(100);
      touchSensorValue = i;                        //set touchSensorValue variable to the touch pad number that is being interacted with
      
//
//      switch(touchSensorValue)  {                //turn on LED's and set touch sensor val based on which sensor is touched
//        case 8:                        
//        digitalWrite(ledBlue, HIGH);
//        digitalWrite(ledRed, LOW);
//        digitalWrite(ledGreen, LOW);
//        digitalWrite(ledYellow, LOW);
//        Serial.println(touchSensorValue);
//        break;
//      case 9:
//        digitalWrite(ledBlue, LOW);
//        digitalWrite(ledRed, HIGH);
//        digitalWrite(ledGreen, LOW);
//        digitalWrite(ledYellow, LOW);
//        Serial.println(touchSensorValue);
//        break;
//      case 10:
//        digitalWrite(ledBlue, LOW);
//        digitalWrite(ledRed, LOW);
//        digitalWrite(ledGreen, HIGH);
//        digitalWrite(ledYellow, LOW);
//        Serial.println(touchSensorValue);
//        break;
//      case 11:
//        digitalWrite(ledBlue, LOW);
//        digitalWrite(ledRed, LOW);
//        digitalWrite(ledGreen, LOW);
//        digitalWrite(ledYellow, HIGH);
//        Serial.println(touchSensorValue);
//        break;
//    
//      default:
//        break;
//      }
   }

    //Blue LED
    if (touchsensor.touched&(1<<i) && touchSensorValue == 8)  {     //turn on Blue LED's if touch sensors not being interacted with
        digitalWrite(ledBlue, HIGH);
    }
    else if (!touchsensor.touched&(1<<i) && touchSensorValue != 8)  {    //turn off Blue LED's if touch sensors not being interacted with
        digitalWrite(ledBlue, LOW);
    }
  
    //Red LED
    if (touchsensor.touched&(1<<i) && touchSensorValue == 9)  {    //turn on Red LED's if touch sensors not being interacted with
        digitalWrite(ledRed, HIGH);
    }
    else if (!touchsensor.touched&(1<<i) && touchSensorValue != 9)  {     //turn off Red LED's if touch sensors not being interacted with
        digitalWrite(ledRed, LOW);
    }
  
    //Green LED
    if (touchsensor.touched&(1<<i) && touchSensorValue == 10)  {     //turn on Green LED's if touch sensors not being interacted with
        digitalWrite(ledGreen, HIGH);
    }
    else if (!touchsensor.touched&(1<<i) && touchSensorValue != 10)  {    //turn off Green LED if touch sensors not being interacted with
        digitalWrite(ledGreen, LOW);
    }
  
    //Yellow LED
    if (touchsensor.touched&(1<<i) && touchSensorValue == 11)  {     //turn on Yellow LED if touch sensors not being interacted with
        digitalWrite(ledYellow, HIGH);
    }
    else if (!touchsensor.touched&(1<<i) && touchSensorValue != 11)  {     //turn off Yellow LED if touch sensors not being interacted with
        digitalWrite(ledYellow, LOW);
    }

   
   //turn off LED's and set touch sensor value if touch sensors not being interacted with
   if (!touchsensor.touched&(1<<i))  {     
//      digitalWrite(ledBlue, LOW);
//      digitalWrite(ledRed, LOW);
//      digitalWrite(ledGreen, LOW);
//      digitalWrite(ledYellow, LOW);
      touchSensorValue = 13;
   }
 }
}
