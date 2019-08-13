class CoordinateSystem
{
  private float csize = 800;
  private float cdepth = 900;
  private float systemSize = 500, 
    rotationX= radians(0), rotationY=radians(0), rotationZ=radians(0);

  CoordinateSystem(float rotationX, float rotationY, float rotationZ)
  {
    this.rotationX = radians(rotationX);
    this.rotationY = radians(rotationY);
    this.rotationZ = radians(rotationZ);
  }

  CoordinateSystem()
  {
  }

  public void renderShape()
  {
    pushMatrix();
    /*
    middle of window:
     */
    

    /*
    Set given Rotation, default = 0:
     */
    rotateX(rotationX);
    rotateY(rotationY);
    rotateZ(rotationZ);


    /*
    Color of Shape and Outline
     */
    background(255);
    //fill(224, 224, 224);
    strokeWeight(2.5);

    /*
    Draw the Shape:
     */
    drawCoordinateSystem(systemSize);


    popMatrix();
  }

  private void drawCoordinateSystem(float size)
  {
    /*
    Draws eachs axes with a word attatched to it
     */
    /*
    draw X axes red
     */
    stroke(255, 0, 0);

    line(0, 0, 0, size, 0, 0);
    Zylinder zx= new Zylinder(6, 2, size, 10);
    zx.setColor(color(255,0,0));
    zx.setRotation(0,radians(90), 0);
    zx.renderShape();
    
    pushMatrix();
    translate(-zx.sheight/2,0,0);
    Konus kx = new Konus(6,4,(float)size/4);
    kx.setColor(color(255,0,0));
    kx.setRotation(0,-radians(90),0);
    
    
    kx.renderShape();
    popMatrix();
    
    xyz.drawWordattachedto("X", 0, 20, size, 0, 0);

    /*
    draw Y axes green
     */
    stroke(0, 255, 0);
    line(0, 0, 0, 0, size, 0);
    
    
    Zylinder zy= new Zylinder(6, 2, size, 10);
    zy.setColor(color(0,255,0));
    zy.setRotation(radians(90),0, 0);
    zy.renderShape();
    xyz.drawWordattachedto("Y", 0, 20, 0, size, 0);
    
    pushMatrix();
    translate(0,-zy.sheight/2,0);
    Konus ky = new Konus(6,4,(float)size/4);
    ky.setColor(color(0,255,0));
    ky.setRotation(radians(90),0,0);
    
    
    ky.renderShape();
    popMatrix();

    /*
    draw Z axes blue
     */
    stroke(0, 0, 255);
    line(0, 0, 0, 0, 0, size);
    xyz.drawWordattachedto("Z", 0, 20, 0, 0, size);
    
    
    Zylinder zz= new Zylinder(6, 2, size, 10);
    zy.setColor(color(0,0,255));
    zz.setRotation(0,0,0);
    zz.renderShape();
    
    pushMatrix();
    translate(0,0,zz.sheight/2);
    Konus kz = new Konus(6,4,(float)size/4);
    kz.setColor(color(0,0,255));
    kz.setRotation(0,0,0);
    
    
    kz.renderShape();
    popMatrix();
    
    
  }

  public void setRotation(float rotationX, float rotationY, float rotationZ)
  {
    /*
    set the rotation of the object to the given rotation
     */
    this.rotationX = rotationX;
    this.rotationY = rotationY;
    this.rotationZ = rotationZ;
  }

  public void drawWordattachedto(String s, color c, int textSize, float posx, float posy, float posz)
  {
    /*
    draws a word on the given position, with the rotation of this object
     given position is x,y or z axes
     */
    pushMatrix();
    fill(c);               
    translate(posx, posy, posz);  
    rotateX(rotationX);
    rotateY(rotationY);
    rotateZ(rotationZ);
    textSize(textSize);
    text(s, 0, 0);                 
    popMatrix();
  }
}