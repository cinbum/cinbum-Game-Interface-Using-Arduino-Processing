#include "pitches.h"
#define Buzzer 23
#define LED 25
int melody[] = {NOTE_C4, NOTE_G3};
#define Joystic_X A0
#define Joystic_Y A1
#define Btn_A 2
#define Btn_B 3  .
#define Btn_C 4
#define Btn_D 53
int xValue = 0; 
int yValue = 0; 
int bValue = 0; 
int cValue = 0;
int dValue = 0;
int eValue = 0;

char val ='H';
char vals = 'S';


 
void setup()
{
 pinMode(LED,OUTPUT);
  Serial.begin(115200);
  pinMode(2, INPUT); 
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
   
}
 
void loop()
{
  xValue = analogRead(A0);        
  yValue = analogRead(A1);  

  bValue = digitalRead(2);  
  cValue = digitalRead(3) ;
  dValue = digitalRead(4) ;
  eValue = digitalRead(5) ;
                  
  Serial.print(xValue+1);
  Serial.print(",");
  Serial.print(yValue+1);
  Serial.print(",");
  Serial.print(!bValue);
  Serial.print(",");
  Serial.print(!cValue +2);
  Serial.print(",");
  Serial.print(!dValue +4);
  Serial.print(",");
  Serial.print(!eValue +6);
  Serial.print(".");
  delay(2);     

  if(Serial.available() > 0 ){
    val = Serial.read();

    if(val =='H'){
      tone(Buzzer, melody[1]);
      delay(100);
      noTone(Buzzer);
      
    }
    else if (val == 'L'){
      noTone(Buzzer);
    }
    else if(val =='S'){
     digitalWrite(LED,HIGH);
     
    }
    else if(val == 'M'){
      digitalWrite(LED,LOW);
    }
  
    }
    }
  
  

