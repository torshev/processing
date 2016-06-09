int num = 400;
float mx[] = new float[num];
float my[] = new float[num];

import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

float tileCountX = 10;
float tileCountY = 10;
float tileWidth, tileHeight;

float a = 0.0;
float inc = TWO_PI/200.0; // amplitude of tenticle waves

int circleCount;
float endSize, endOffset;

int actRandomSeed = 0;

void setup() {
  size(800, 800, P3D);
  tileWidth = width/tileCountX;
  tileHeight = height/tileCountY;
  fill(255, 50);
  frameRate(30);
}


void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");


  noStroke();
  background(0);
  randomSeed(actRandomSeed);
  colorMode(HSB, 360, 100, 100, 100);
  translate(width/tileCountX/2, height/tileCountY/2);




  circleCount = mouseX/2 +1;
  endSize = map(mouseX, 0, width, tileWidth/4, 0);
  endOffset = map(mouseY, 0, height, 0, (50*tileWidth-endSize)/2);

  pushMatrix();
  translate(width/2-30, height/2-30);
  scale(1, tileHeight/tileWidth);


  //draw module
  for (int i=0; i<circleCount; i++) {
    float diameter = map(i, 0, circleCount-1, tileWidth, endSize);
    float offsetX = map(i, 0, circleCount -1, 0, endOffset/5);
    float offsetY = map(i, 0, circleCount -1, 0, endOffset/5);

    int which = frameCount % num;
    mx[which] = sin(a)*10;
    my[which] = sin(a)*10;
    int index = (which+1 + i) % num;

    color c = color(random(160, 360), 100, 100, 40);
    fill(c);

   
    ellipse(0+offsetX+mx[index]*2, 0-offsetY+my[index]*1.5, 0+diameter, 1*diameter);
    ellipse(27+mx[index]*-2, 0-offsetY+my[index]*0, diameter, diameter);
   ellipse(11-offsetX+mx[index]*5, 0-offsetY+my[index]*0, diameter, diameter);
   ellipse(0+offsetX+mx[index]*-2, 0+my[index]*-3, diameter, diameter);
   ellipse(0+offsetX+mx[index]*5, 0+offsetY+my[index]*1, diameter, diameter);
   ellipse(0-offsetX+mx[index]*-2, 0+my[index]*3, diameter, diameter);
   ellipse(0+mx[index]*-1.8, 0+offsetY+my[index]*1.5, diameter, diameter);
   ellipse(0-offsetX+mx[index]*1.7, 0+offsetY+my[index]/2, diameter, diameter);
  // ellipse(-offsetX+mx[index], offsetY/2.5+my[index], diameter, diameter);
   // ellipse(-offsetX+mx[index], -offsetY/2.5+my[index], diameter, diameter);
   // ellipse(offsetX+mx[index], -offsetY/2.5+my[index], diameter, diameter);
   // ellipse(offsetX+mx[index], -offsetY/2.5+my[index], diameter, diameter);
   // ellipse(offsetX+mx[index], offsetY/2.5+my[index], diameter, diameter);
    
  }


  popMatrix();


  if (savePDF) {
    savePDF = false;
    endRecord();
  }
  
  a += inc;
  println(inc);
}

void mousePressed() {
  actRandomSeed = (int) random(100000);
}


void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}