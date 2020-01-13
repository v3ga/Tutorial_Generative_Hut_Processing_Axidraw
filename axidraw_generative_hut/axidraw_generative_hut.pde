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
float nbFigures = 62;
float angleRotation = 0.07;
float nbWaves = 2;
float radiusMin = 10;
float radiusMax = 200;


// --------------------------------------------------
void setup()
{
//  size(630, 900);
  size(740, 740);
  initParameters();
  initControls();
}

// --------------------------------------------------
void initParameters()
{
  radiusMin = 10;
  radiusMax = 0.5*min(width,height);
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


  for (int n=0; n<nbFigures; n++)
  {
    pushMatrix();
    rotate( map( sin(nbWaves*n/nbFigures*TWO_PI), -1, 1, -angleRotation, angleRotation) );
    
    circle(nbPoints, map(n,0,nbFigures-1,radiusMax, radiusMin));

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

  cp5 = new ControlP5(this);
//  Group groupGlobals = cp5.addGroup("Sketch rotation").setBackgroundHeight(320).setPosition(5, 20).setBarHeight(20).setWidth(400).setBackgroundColor(color(0, 190));
//  groupGlobals.getCaptionLabel().getStyle().marginTop = 6;

  int cp5_height = 18;
  int wSlider = width/2;
  int x = 5;
  int y = 5;
  int margin = 15;
  
  cp5.setBroadcast(false);
  
  cp5.addSlider("nbPoints").setHeight(cp5_height).setWidth(wSlider).setPosition(x,y).setLabel("nb points").setRange(3, 10).setNumberOfTickMarks(10-3).setValue(nbPoints).linebreak();
  y+=cp5_height+margin;
  cp5.addSlider("nbFigures").setHeight(cp5_height).setWidth(wSlider).setPosition(x,y).setLabel("nb figures").setRange(1, 100).setNumberOfTickMarks(100).setValue(nbFigures).linebreak();
  y+=cp5_height+margin;
  cp5.addRange("radius").setHeight(cp5_height).setWidth(wSlider).setPosition(x,y).setLabel("radius").setRange(0, 0.5*min(width,height)).setRangeValues(10,0.5*min(width,height)).linebreak();
  y+=cp5_height+margin;
  cp5.addSlider("nbWaves").setHeight(cp5_height).setWidth(wSlider).setPosition(x,y).setLabel("nb waves").setRange(1, 5).setNumberOfTickMarks(5).setValue(nbWaves).linebreak();
  y+=cp5_height+margin;
  cp5.addSlider("angleRotation").setHeight(cp5_height).setWidth(wSlider).setPosition(x,y).setLabel("rotation").setRange(0, PI/2).setValue(angleRotation).linebreak();

  cp5.setBroadcast(true);
  cp5.setAutoDraw(false);
  cp5.end();
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
