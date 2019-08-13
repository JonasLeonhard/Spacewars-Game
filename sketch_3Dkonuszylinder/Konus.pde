class Konus extends Shape
{
  /*
  Konus class:
   */
 color c = color(153, 204, 255);
  Konus()
  {
  }

  Konus(int segments, float radius, float sheight)
  {
    super.segments = segments;
    super.radius = radius;
    super.sheight = sheight;
  }

  public void renderShape()
  {
    /*
    Translate coordinate system to the middle of the window
     */
    pushMatrix();
    //translate(width/2, height/2, 0);

    /*
    Set Rotation of your shape- defaul = 0:
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
    drawKonus();
    popMatrix();
  }

  private void drawKonus()
  {
    /*
    bottom ring and the connect the body to it:
     */
    drawRing(-sheight/2);
    drawBody();
  }

  private void drawRing(float ringheight)
  {
    /*
     This Method draws the bottom ring. It draws it half the height of 
     the zylinder up in the air. 
     To get the angle between each drawn point you divide a 
     circle (360) by the amount of segments you want to draw.
     To get a Point on any given circle with a radius --> P( cos (alpha)*radius, sin (alpha)*radius)
     */

    beginShape();
    for (int i = 0; i< segments; i++)
    {
      float x = cos( radians(360/segments*i))*radius;
      float y = sin( radians(360/segments*i)) *radius;

      /*
    connects eacht point of bottom ring -ring outline
       */

      vertex(x, y, ringheight);
    }
    endShape(CLOSE);

    beginShape(TRIANGLE_FAN);
    for (int i = 0; i< segments; i++)
    {
      float x = cos( radians(360/segments*i))*radius;
      float y = sin( radians(360/segments*i)) *radius;

      /*
    connects eacht point of bottom ring with its middle - ring middle edges
       */
      vertex(0, 0, ringheight);
      vertex(x, y, ringheight);
    }
    endShape(CLOSE);
  }

  private void drawBody()
  {
    /*
    This Method draw the Body of the Konus. It connects the middle point P(0,0) with the height/2 
     with each vertex of the bottom Ring. 
     */
    beginShape(QUAD_STRIP);
    for (int i =0; i< segments +1; i++)
    {
      float x = cos ( radians(i*360/segments)) *radius;
      float y = sin ( radians(i*360/segments)) *radius;

      /*
      connects P(0,0,konusheigt/2) with each Point of bottom ring 
       */
      vertex(0, 0, sheight/2); 
      vertex(x, y, -sheight/2);
    }
    endShape(CLOSE);
  }
  
  void setColor(color c)
{
  this.c = c;
}
}