/*

Processing + Axidraw — Generative hut tutorial by Julien "v3ga" Gachadoat
January 2020
www.generativehut.com
—

www.instagram.com/julienv3ga
https://twitter.com/v3ga
https://github.com/v3ga

*/

// --------------------------------------------------
import processing.svg.*;
import java.util.*;
import controlP5.*;

// --------------------------------------------------
boolean bExportSVG = false;
ControlP5 cp5;

// --------------------------------------------------
int nbPoints = 5;

float nbForms = 62;
float radiusMin = 10;
float radiusMax = 370;

float nbWaves = 2;
float angleRotation = 0.07;

// --------------------------------------------------
void setup()
{
  size(800, 800);
  initControls();
}

// --------------------------------------------------
void draw()
{
  // White background
  // The function is called before beginRecord 
  background(255);

  // Start recording if the flag bExportSVG is set
  // When recording, all Processing drawing commands will be displayed on screen and saved into a file
  // The filename is set with a timestamp 
  if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/svg/export_"+timestamp()+".svg");
  }


  // Drawing options : no fill and stroke set to black  
  noFill();
  stroke(0);

  // Translate the origin to the center of screen
  pushMatrix();
  translate(width/2, height/2);

  // Start drawing here
  for (int n=0; n<nbForms; n++)
  {
    pushMatrix();
    rotate( map( sin(nbWaves*n/(nbForms-1)*TWO_PI), -1, 1, -angleRotation, angleRotation) );

    circle(nbPoints, map(n, 0, nbForms-1, radiusMax, radiusMin));

    popMatrix();
  }
  // End drawing here

  // Reset origin
  popMatrix();

  // If we were exporting, then we stop recording and set the flag to false
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }


  drawControls();
}

// --------------------------------------------------
void keyPressed()
{
  if (key == 'e')
  {
    bExportSVG = true;
  }
}

// --------------------------------------------------
void circle(int nbPoints, float radius)
{
  beginShape();
  for (int i=0; i<nbPoints; i++)
  {
    float angle = -PI/2+float(i)*TWO_PI/float(nbPoints);
    vertex( radius*cos(angle), radius*sin(angle) );
  }
  endShape(CLOSE);
}

// --------------------------------------------------
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

// --------------------------------------------------
void initControls()
{

  int hSlider = 18;
  int wSlider = width/2;
  int x = 5;
  int y = 5;
  int margin = 15;

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cp5.setBroadcast(false);

  cp5.addSlider("nbPoints").setSize(wSlider, hSlider).setPosition(x, y).setLabel("nb points").setRange(3, 10).setNumberOfTickMarks(10-3).setValue(nbPoints);
  y+=hSlider+margin;
  cp5.addSlider("nbForms").setSize(wSlider, hSlider).setPosition(x, y).setLabel("nb forms").setRange(1, 100).setNumberOfTickMarks(100).setValue(nbForms);
  y+=hSlider+margin;
  cp5.addRange("radius").setSize(wSlider, hSlider).setWidth(wSlider).setPosition(x, y).setLabel("radius range").setRange(10, 370).setRangeValues(radiusMin, radiusMax);
  y+=hSlider+margin;
  cp5.addSlider("nbWaves").setSize(wSlider, hSlider).setWidth(wSlider).setPosition(x, y).setLabel("nb waves").setRange(1, 5).setNumberOfTickMarks(5).setValue(nbWaves);
  y+=hSlider+margin;
  cp5.addSlider("angleRotation").setSize(wSlider, hSlider).setPosition(x, y).setLabel("rotation").setRange(0, PI/2).setValue(angleRotation);

  cp5.setBroadcast(true);
}
// --------------------------------------------------
void controlEvent(ControlEvent theControlEvent) 
{
  if (theControlEvent.isFrom("radius")) 
  {
    radiusMin = int(theControlEvent.getController().getArrayValue(0));
    radiusMax = int(theControlEvent.getController().getArrayValue(1));
  }
}

// --------------------------------------------------
void drawControls() 
{
  pushStyle();
  noStroke();
  fill(0, 100);
  rect(0, 0, width, 160);
  popStyle();
  cp5.draw();
}
