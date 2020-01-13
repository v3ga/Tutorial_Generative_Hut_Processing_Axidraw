// --------------------------------------------------
int dim = 740;
int res = 3;
float radius=0;
PGraphics pg;
PGraphics composition;

// --------------------------------------------------
void settings()
{
  size(740, 740);
}

// --------------------------------------------------
void setup()
{
  composition = createGraphics(dim*4, dim*2);
  composition.beginDraw();
  composition.background(255);
  composition.endDraw();

  pg = createGraphics(dim, dim);

  radius = 0.45*width;
  int index=0;
  float x,y;
  for (int res=3; res<=10; res++)
  {
    index = res-3;
    x = dim * (index%4);
    y = dim * (index/4);
    
    pg.beginDraw();
    pg.background(255);
    pg.noFill();
    pg.translate(pg.width/2, pg.height/2);
    pg.strokeWeight(2);    
    pg.stroke(0, 50);
    pg.ellipse(0, 0, 2*radius, 2*radius);
    pg.strokeWeight(3);    
    pg.stroke(0);
    circle(pg, res, radius);
    pg.endDraw();

    composition.beginDraw();
    composition.image(pg,x,y);
    composition.endDraw();
  }

  composition.save("composition.png");
  noLoop();
}

// --------------------------------------------------
void draw()
{
}

// --------------------------------------------------
void circle(PGraphics pg, int nb, float radius)
{
  pg.beginShape();
  for (int i=0; i<nb; i++)
  {
    float angle = -PI/2+float(i)*TWO_PI/float(nb);
    pg.vertex( radius*cos(angle), radius*sin(angle) );
  }
  pg.endShape(CLOSE);
}
