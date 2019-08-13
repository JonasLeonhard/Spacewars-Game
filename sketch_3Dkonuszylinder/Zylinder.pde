class Zylinder extends Shape
{
  /*
  Diese Klasse beschreibt einen Zylinder
   */
  private int rings;
  color c = color(153, 204, 255);

  Zylinder()
  {
  }


  Zylinder(int segmentamount, float rad, float sh, int r)
  {
    super.segments = segmentamount;
    super.radius = rad;
    super.sheight = sh;
    this.rings = r;
  }

  public void setRings(int rings)
  {
    this.rings = rings;
  }

  public void renderShape()
  {
    /*
    Translate coordinate system to the middle of the window
     */
    pushMatrix();
    //translate(width/2, height/2, 0);

    /*
    Set Rotation:
     */
    rotateX(rotationX);
    rotateY(rotationY);
    rotateZ(rotationZ);

    /*
    Color of Shape and Outline
     */
    fill(c);
    strokeWeight(1);
    stroke(0);


    /*
    Draw the Shape:
     */
    drawCylinder();
    popMatrix();
  }

  private void drawCylinder()
  {
    /*
    This draws the different Parts of the Cylinder, it first draws
     bot outside rings, the it connects them with each other
     Draw amout of rings height/segments
     */

    /*
    draw Ring Segments from bottom to top
     */
    float ringheight = -sheight/2; 
    for (int i = 0; i<= rings; i++)
    {
      drawRing(ringheight);
      ringheight += sheight/rings;
    }

    /*
    draw Ring at bottom and Top
     */
    //drawRing(sheight/2);
    //drawRing(-sheight/2);

    /*
    connect bottom and Top
     */
    drawBody();
  }




  private void drawBody()
  {
    /*
    This Method connects each point of the top Ring with the bottom ring
     */
    beginShape(QUAD_STRIP);
    for (int i =0; i< segments +1; i++)
    {
      float x = cos ( radians(360/segments*i)) *radius;
      float y = sin ( radians(360/segments*i)) *radius;

      /*
      connect each vertex of the bottom and top ring
       */
      vertex(x, y, sheight/2);
      vertex(x, y, -sheight/2);
    }
    endShape(CLOSE);
  }

  private void drawRing(float ringheight)
  {
    /*
    -This Method draws the top ring. It draws it half the height of 
     the zylinder up in the air. 
     -To get the angle between each drawn point you divide a 
     circle (360) by the amount of segments you want to draw.
     -To get a Point on any given circle with a radius --> P( cos alpha*radius, sin alpha*radius)
     */

    beginShape();
    for (int i = 0; i< segments; i++)
    {
      float x = cos( radians( i*360/segments))*radius;
      float y = sin( radians(i*360/segments)) *radius;

      /*
    connects eacht point of bottom ring - Ring outline
       */

      vertex(x, y, ringheight);
    }
    endShape(CLOSE);

    beginShape(TRIANGLE_FAN);
    for (int i = 0; i< segments; i++)
    {
      float x = cos( radians( i*360/segments))*radius;
      float y = sin( radians(i*360/segments)) *radius;

      /*
    connects eacht point of bottom ring with the middle of it - Ring middle edges
       */
      vertex(0, 0, ringheight);
      vertex(x, y, ringheight);
    }
    endShape(CLOSE);
  

  }
void setColor(color c)
{
  this.c = c;
}
  }