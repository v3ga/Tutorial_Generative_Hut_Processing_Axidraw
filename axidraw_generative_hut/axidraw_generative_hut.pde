// Sketch inspiré de https://turtletoy.net/turtle/f8526463e9

// --------------------------------------------------
import processing.svg.*;
import java.util.*;
import controlP5.*;

// --------------------------------------------------
boolean bExportSVG = false;
boolean bExportFrame = false;
ControlP5 cp5;

// --------------------------------------------------
int nbPoints = 3;

float nbForms = 62;
float radiusMin = 10;
float radiusMax = 350;

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
  background(255);
  if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/svg/export_"+timestamp()+".svg");
  }


  // DÉBUT des commandes de dessin
  noFill();
  stroke(0);

  pushMatrix();
  translate(width/2, height/2);


  for (int n=0; n<nbForms; n++)
  {
    pushMatrix();
    rotate( map( sin(nbWaves*n/(nbForms-1)*TWO_PI), -1, 1, -angleRotation, angleRotation) );
    
    circle(nbPoints, map(n,0,nbForms-1,radiusMax, radiusMin));

    popMatrix();
  }

  popMatrix();

  // FIN des commandes de dessin
  if (bExportFrame)
  {
    saveFrame("data/exports/images/export_"+timestamp()+".png");
    bExportFrame = false;
  }
  
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
  else if (key == 's')
  {
    bExportFrame = true;
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
  
  cp5.addSlider("nbPoints").setSize(wSlider,hSlider).setPosition(x,y).setLabel("nb points").setRange(3, 10).setNumberOfTickMarks(10-3).setValue(nbPoints);
  y+=hSlider+margin;
  cp5.addSlider("nbForms").setSize(wSlider,hSlider).setPosition(x,y).setLabel("nb forms").setRange(1, 100).setNumberOfTickMarks(100).setValue(nbForms);
  y+=hSlider+margin;
  cp5.addRange("radius").setSize(wSlider,hSlider).setWidth(wSlider).setPosition(x,y).setLabel("radius range").setRange(0, 370).setRangeValues(radiusMin,radiusMax);
  y+=hSlider+margin;
  cp5.addSlider("nbWaves").setSize(wSlider,hSlider).setWidth(wSlider).setPosition(x,y).setLabel("nb waves").setRange(1, 5).setNumberOfTickMarks(5).setValue(nbWaves);
  y+=hSlider+margin;
  cp5.addSlider("angleRotation").setSize(wSlider,hSlider).setPosition(x,y).setLabel("rotation").setRange(0, PI/2).setValue(angleRotation);


}

// --------------------------------------------------
void drawControls() 
{
  pushStyle();
  noStroke();
  fill(0,100);
  rect(0,0,width,160);
  popStyle();
  cp5.draw();
}

// --------------------------------------------------
void controlEvent(ControlEvent theControlEvent) 
{
  if(theControlEvent.isFrom("radius")) 
  {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    radiusMin = int(theControlEvent.getController().getArrayValue(0));
    radiusMax = int(theControlEvent.getController().getArrayValue(1));
  }
  
}
