import processing.serial.*;
import processing.sound.*;
import ddf.minim.*;

Minim minim;

Ball ball3;  // player
Ball ball4;  // bullet


Ball [] ball = new Ball[15];

Serial myPort;
AudioPlayer song;


int x;    // JoyStick X
int y;     // JoyStick Y
int b;     // A Button
int c1;     // B Button
int d;     // C Button
int e;     // D Button
int f = 0;
int s = 0;

void setup(){ 
  minim = new Minim(this);
  song = minim.loadFile("bk.mp3",2048);
  song.play();
  song.loop();
  
  size(1200,1000);
  for(int i = 0; i<ball.length; i++){
    ball[i] = new Ball(20);
  }
  ball3 = new Ball(10);
  ball4 = new Ball(5);

  
  myPort = new Serial(this, "COM3", 115200);
}

void draw(){
 
  background(255);
  title();
  for(int i =0; i<ball.length; i++){
   ball[i].move();
   ball[i].display();
  }

  ball3.player();   // player move
  ball4.Bullet();
  ball4.Shoot();

  // target display


  
for(int i = 0; i<ball.length; i++){
  if(ball[i].intersect(ball4)){

     ball[i].Caught();
     ball[i].Sound();
     s++;
     if(i == ball.length)
      i = 0;
  }
  if(ball[i].intersectC(ball4)){
      s++;
     ball[i].Caught();
     ball[i].Sound();
     if(i == ball.length)
      i = 0;
  }
  if(ball[i].intersectD(ball4)){
    s++;
     ball[i].Caught();
     ball[i].Sound();
     if(i == ball.length)
      i = 0;
  }
  if(ball[i].intersectE(ball4)){
     s++;
     ball[i].Caught();
     ball[i].Sound();
     if(i == ball.length)
      i = 0;
  }
  if(ball[i].intersect(ball3)){

     ball[i].highlight();
     ball[i].Sound();
     ball[i].Reset();
     ball[i].Light();
     f++;
     s = 0;
  }
}
}
void loop(){
  for(int i = 0; i<10; i++){
  song.play();
  }
}





void serialEvent(Serial port){
  try{
  String input = port.readStringUntil('.');
  if (input != null){
    String [] vals = split(input,',');
    x = int(vals[0]);
    y = int(vals[1]);
    b = int(vals[2]);
    c1 = int(vals[3]);
    d = int(vals[4]);
    e = int(vals[5].replace(".","")); 
  }
}
  catch(Exception e){
  }
}


class Ball{
  float r;                  // radius
  float r1;
  float x2,y2;                // location
  float xspeed,yspeed;      // speed
  color c = color(100,50);  // color
  color c2 = color(70);
  float X,Y;                // A Bullet
  float X1,Y1;              // B Bullet
  float X2,Y2;              // C Bullet
  float X3,Y3;              // D Bullet
  float bxSpeed, bySpeed;
Ball(float tempR){
  r = tempR;
  r1 = tempR;
  x2 = random(width);
  y2 = random(height);
  xspeed = random(-5,5);
  yspeed = random(-5,5);
  X =-1000; 
  Y =1000-y;
  X1 =x+100; 
  Y1 =1000-y;
  X2 =x+100; 
  Y2 =1000-y;
  X3 =x+100; 
  Y3 =1000-y;
  bxSpeed = 3;
  bySpeed = -3;
}

void Reset(){
  x2 = random(width);
  y2 = random(height);
  xspeed = random(-5,5);
  yspeed = random(-5,5);

}

void Caught(){
  xspeed=0;
  yspeed=0;
  y2=-100000;
}

void Bullet(){
 
  if(b == 1){

   bySpeed = -5;
   Y  += bySpeed;
  if(X > width || X < 0){
    bxSpeed *= -1;
  }
  if(Y > height || Y < 0){
    bySpeed *= 1;
    X = x+100; 
    Y =1000-y;
  }
 }
 if(b == 0){
   bySpeed = -5;
   Y += bySpeed;
 }
 if(c1 == 3){
    bxSpeed = 5;
    X1  += bxSpeed;
   if(X1 > width || X1 < 0){
    bxSpeed *= 1;
    X1 = x+100; 
    Y1 = 1000-y;
  }
   if(Y1 > height || Y1 < 0){
    bySpeed *= -1;
   }
 }
 if(c1 == 2){
    bxSpeed = 5;
    X1  += bxSpeed;
 }
 if(d == 5){
   bySpeed = 5;
   Y2  += bySpeed;
  if(X2 > width || X2 < 0){
    bxSpeed *= -1;
  }
  if(Y2 > height || Y2 < 0){
    bySpeed *= 1;
    X2 = x+100; 
    Y2 =1000-y;
  }
 }
 if(d == 4){
   bySpeed = 5;
   Y2  += bySpeed;
 }
 if(e == 7){
    bxSpeed = -5;
    X3  += bxSpeed;
   if(X3 > width || X3 < 0){
    bxSpeed *= 1;
    X3 = x+100; 
    Y3 = 1000-y;
  }
   if(Y3 > height || Y3 < 0){
    bySpeed *= -1;
   }
 }
if(e == 6){
  bxSpeed = -5;
  X3  += bxSpeed;
}
}
void Light(){
  myPort.write("S");
  delay(1);
  myPort.write("M");

}
void Sound(){
  myPort.write("H");
  delay(1);
  myPort.write("L");
}

void Shoot(){

  if(b == 1 || b == 0) {
    fill(0,255,0);
    ellipse(X,Y--, 5, 5);
    println(X);
    println(Y);
  }

 if(c1 == 3 || c1 == 2){
    fill(0,255,0);
    ellipse(X1++,Y1, 5, 5);
    println(X);
    println(Y);
 }

if(d == 5 || d == 4){
    fill(0,255,0);
    ellipse(X2,Y2++, 5, 5);
    println(X);
    println(Y);
}


if(e == 7 || e == 6){
     fill(0,255,0);
    ellipse(X3--,Y3, 5, 5);
    println(X);
    println(Y);
}

}
void move(){
  
  x2 += xspeed;
  y2 += yspeed;
  
  if(x2 > width || x2 < 0){
    xspeed *= -1;
  }
  if(y2 > height || y2 < 0){
    yspeed *= -1;
  }
  
}
void highlight(){
c = color(255,0,0);
}

void display(){

  stroke(0);
  fill(c);
  ellipse(x2, y2, r*2, r*2);

}
 
boolean intersect(Ball b){

  float distance = dist(x2, y2, b.X, b.Y);
  if(distance < r + b.r1){
    return true;
  }
  else{
    return false;
  }
}

boolean intersectC(Ball b){

  float distance = dist(x2, y2, b.X1, b.Y1);
  if(distance < r + b.r1){
    return true;
  }
  else{
    return false;
  }
}
boolean intersectD(Ball b){

  float distance = dist(x2, y2, b.X2, b.Y2);
  if(distance < r + b.r1){
    return true;
  }
  else{
    return false;
  }
}

boolean intersectE(Ball b){

  float distance = dist(x2, y2, b.X3, b.Y3);
  if(distance < r + b.r1){
    return true;
  }
  else{
    return false;
  }
}
void player(){
     stroke(0);
     fill(c2);
     c2 = color(70);
     X = x+100;
     Y = 1000-y;
     ellipse(X,Y, r1, r1);
     
     println(x);
     println(X);

}
}

void title(){
  textSize(20);
  fill(100,50,100);
  text("Player Death : " +f,width/30,height/30);

  text("Player Score : " + s , width /5, height/30);
}



  
 
 
 
 
 
 

 