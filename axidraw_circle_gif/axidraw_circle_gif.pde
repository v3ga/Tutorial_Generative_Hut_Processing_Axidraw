// --------------------------------------------------
import gifAnimation.*;

// --------------------------------------------------
int dim = 740;
int res = 3;
float radius=0;
GifMaker gifExport;
PFont font;
int MODE_NB_POINTS = 1;
int MODE_NB_FIGURES = 2;
int MODE_NB_WAVES = 3;
int mode = MODE_NB_WAVES;

// --------------------------------------------------
void setup()
{
  size(740, 740);
  font = loadFont("Monaco-18.vlw");
  radius = 0.45*width;
  String filename="";
  float xText=0;

  if (mode == MODE_NB_POINTS)
  {
    gifExport = new GifMaker(this, "circle_nb_points.gif", 100);
    gifExport.setRepeat(0);
    for (int res=3; res<=10; res++)
    {
      background(255);
      stroke(0);
      strokeWeight(2); 
      noFill();
      pushMatrix();
      translate(width/2, height/2);
      circle(res, radius);
      popMatrix();
      fill(0);
      textFont(font);
      textSize(18);
      String s = "nbPoints="+res;
      if (res < 10)
        xText = (width-textWidth(s))/2;
      text(s, xText, height-10);

      gifExport.setDelay(750);
      gifExport.addFrame();
    }
    gifExport.finish();
  } else if (mode == MODE_NB_FIGURES)
  {
    gifExport = new GifMaker(this, "circle_nb_forms.gif", 100);
    gifExport.setRepeat(0);
    int nbPoints = 5; 
    float radiusMin = 0.15*width;
    float radiusMax = 0.45*width;
    for (int nb=1; nb<=20; nb++)
    {
      background(255);
      stroke(0);
      strokeWeight(2); 
      noFill();
      pushMatrix();
      translate(width/2, height/2);
      for (int i=1; i<=nb; i++)
        circle(nbPoints, i == 1 ? radiusMax : map(i, 1, nb, radiusMax, radiusMin));
      popMatrix();
      fill(0);
      textFont(font);
      textSize(18);
      String s = "nbForms="+nb;
      if (nb < 10)
        xText = (width-textWidth(s))/2;
      text(s, xText, height-10);
      gifExport.setDelay(200);
      gifExport.addFrame();
    }
    gifExport.finish();
  } else if (mode == MODE_NB_WAVES)
  {

    int nbPoints = 5; 
    int nbForms = 40;
    float angleRotation = 0.07*3;
    float radiusMin = 0.15*width;
    float radiusMax = 0.45*width;
    gifExport = new GifMaker(this, "circle_nb_waves_"+angleRotation+".gif", 100);
    gifExport.setRepeat(0);
    for (int nbw=1; nbw<=5; nbw++)
    {
      background(255);
      stroke(0);
      strokeWeight(2); 
      noFill();
      for (int n=0; n<nbForms; n++)
      {
        pushMatrix();
        translate(width/2, height/2);
        rotate( map( sin(float(nbw)*float(n)/(nbForms-1)*TWO_PI), -1, 1, -angleRotation, angleRotation) );
        circle(nbPoints, n == 0 ? radiusMax : map(n, 0, nbForms-1, radiusMax, radiusMin));
        popMatrix();
      }
      fill(0);
      textFont(font);
      textSize(18);
      String sr = "angleRotation="+angleRotation;
      String s = "nbWaves="+nbw;
      xText = (width-textWidth(sr))/2;
      text(sr, xText, height-40);
      text(s, xText, height-10);
      gifExport.setDelay(750);
      gifExport.addFrame();
    }
    gifExport.finish();
  }





  noLoop();
}


// --------------------------------------------------
void draw()
{
}

// --------------------------------------------------
void circle(int nb, float radius)
{
  beginShape();
  for (int i=0; i<nb; i++)
  {
    float angle = -PI/2+float(i)*TWO_PI/float(nb);
    vertex( radius*cos(angle), radius*sin(angle) );
  }
  endShape(CLOSE);
}
