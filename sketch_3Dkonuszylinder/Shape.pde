class Shape
{
  /*
  Superclass with Segmenst of circles, circle radius, shape height and shaperotation
   */
  protected int segments = 0;
  protected float radius = 0, sheight = 0, 
    rotationX= radians(0), rotationY=radians(0), rotationZ=radians(0);


  Shape()
  {
  }

  public void setSegments(int segments)
  {
    /*
    sets the Segments of each circle
     */
    this.segments = segments;
  }

  public void setRadius(float radius)
  {
    /*
    sets the circle radius
     */
    this.radius = radius;
  }

  public void setHeight(float sheight)
  {
    /*
    sets the Height of the shape
     */
    this.sheight = sheight;
  }

  public void setRotation(float rotationX, float rotationY, float rotationZ)
  {
    /*
  sets the x,y,z rotation of the shape 
     */
    this.rotationX = rotationX;
    this.rotationY = rotationY;
    this.rotationZ = rotationZ;
  }
}