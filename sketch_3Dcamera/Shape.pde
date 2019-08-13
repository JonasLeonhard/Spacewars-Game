class Shape
{
  /*
  Superclass with Segmenst of circles, circle radius, shape height and shaperotation
   */
  protected int segments = 0;
  protected float radius = 0, sheight = 0, 
    rotationX= radians(0), rotationY=radians(0), rotationZ=radians(0);

  protected PVector position = new PVector(0, 0, 0);

  Shape()
  {
    xyz = new CoordinateSystem(rotationX, rotationY, rotationZ);
    //println("Shape Konstruktor");
  }

  /*
  lets you set the current position of your Shape - 
   gets used to translate to position later:
   */
  public void setX(float x)
  {
    position.x = x;
  }
  public void setY(float y)
  {
    position.y = y;
  }
  public void setZ(float z)
  {
    position.z = z;
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

    xyz.setRotation(rotationX, rotationY, rotationZ);
  }

  public void renderShape()
  {

    //println("Shape.renderShape");
  }
}