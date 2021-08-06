/*REFERENCES: 
 - I2C Multi Touch Grove Sensor source code from: https://electropeak.com/learn/interfacing-grove-12-key-multi-touch-sensor-with-arduino/

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
String touchSensorKey;

int touchSensorValue = 13;
int buttonPin = 7;
int potPin = 0;

int potVal;
int buttonState = 0;



void setup()  {    
    Serial.begin(9600); // for debugging   
    Serial.print("begin to init");  
    Wire.begin(); // needed by the GroveMultiTouch lib     
    touchsensor.initialize(); // initialize the feelers     // initialize the containers     

    pinMode(ledBlue, OUTPUT);
    pinMode(ledRed, OUTPUT);
    pinMode(ledGreen, OUTPUT);
    pinMode(ledYellow, OUTPUT);

    pinMode(buttonPin, INPUT);
  }
  
void loop() {     
 //I2C Multi Touch Grove Sensor variables
 unsigned char MPR_Query=0;
 unsigned long currentMillis = millis();

 //hold slider sensor (potentiometer) analog reading and button digital reading within variables
 potVal = analogRead(potPin)/4;
 buttonState = digitalRead(buttonPin);

 //get touchsensor state that can be checked
 if(currentMillis - previousMillis > interval)  {
    previousMillis = currentMillis;
    touchsensor.getTouchState();
 }

 for (int i=0;i<12;i++) {
    if (touchsensor.touched&(1<<i))  {             //check if touch sensor is being touched
//      Serial.print("pin ");
//      Serial.print(i);
//      Serial.println(" was  touched");
//      delay(100);
      touchSensorValue = i;                        //set touchSensorValue variable to the touch pad number that is being interacted with
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

   
   //Turn off LED's and set touch sensor value if touch sensors not being interacted with
   if (!touchsensor.touched&(1<<i))  {     
      touchSensorValue = 13;
   }
 }

  //Serial monitor println control
  //start of 'a' packet
  Serial.print("a");
  Serial.print(touchSensorValue);
  Serial.print("a");
  Serial.println(); //end of 'a' packet

  //start of 'b' packet
  Serial.print("b"); //character 'b' will delimit the reading from the slider sensor
  Serial.print(potVal);
  Serial.print("b");
  Serial.println(); //end of 'b' packet

  //start of 'c' packet
  Serial.print("c"); //character 'c' will delimit the reading from the slider sensor
  Serial.print(buttonState);
  Serial.print("c");
  Serial.println(); //end of 'c' packet
  
  Serial.print("&"); //denotes end of readings from both sensors

  //print carriage return and newline
  Serial.println(); 
  delay(100);
}
