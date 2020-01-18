/*

Processing + Axidraw — Generative hut tutorial by Julien "v3ga" Gachadoat
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

// --------------------------------------------------
boolean bExportSVG = false;

// --------------------------------------------------
void setup()
{
  size(800, 800);
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

  // Start drawing here

  
  // End drawing here

  // If we were exporting, then we stop recording and set the flag to false
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
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
// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
