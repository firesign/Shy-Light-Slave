/* Shy Light Slave 001
 by Michael B. LeBlanc
 NSCAD University
 Feb. 27, 2011
 
 This code controls the servo.
 
 */


#include <Servo.h> 

Servo myservo;  // create servo object to control a servo 

boolean switchPress = LOW; // initialize switch state
int pos = 180;    // variable to store the servo position 

#define switchPin 4 // used to receive commands from master unit

void setup() {
  //Serial.begin(9600);
  myservo.attach(5);  // attaches the servo on pin 5 to the servo object
  myservo.write(pos);
}

void loop() {

  switchPress = digitalRead(switchPin);
  // Wait for someone to press the switch
  if (switchPress == HIGH) {
    basket();
  }
}

void basket() {
  openBasket();
  timeOut();
  closeBasket(); 
}

void openBasket() {
  myservo.attach(5); // wake up the servo motor
  //Serial.println("Lights down slowly:");
  int finePos = 0;
  for (int i=17; i>=0; i--) 
  {
    pos = i * 10;
    for (int f=9; f>=0; f--) 
    {
      finePos = pos + f;
      myservo.write(finePos);
      delay(20);
    }
  }
  myservo.write(finePos);
  myservo.detach(); // rest the servo motor
}

void timeOut() { 
  // wait 30 seconds or for another switchpress
  long currTime = millis();
  long delayTime = currTime + 30000;
  do { 
    // 30 second loop
    currTime = millis();
    switchPress = digitalRead(switchPin);
  } 
  while (switchPress == LOW && delayTime > currTime);
}

void closeBasket() 
{
  //Serial.println("Lights up slowly:");
  myservo.attach(5); // wake up the servo motor
  int finePos = 9;
  for (int i=1; i<=18; i++) 
  {
    pos = i * 10;
    for (int f=0; f<=9; f++) 
    {
      finePos = pos + f - 10;
      myservo.write(finePos);
      delay(20);
    }
  }
  myservo.write(finePos);
  myservo.detach(); // rest the servo motor
}

