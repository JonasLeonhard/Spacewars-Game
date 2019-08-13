
/*
Author Jonas Leonhard
 This Program creates a Cordinate System, a Konus and a Zylinder.
 Press 'z' to switch Zylinder on and off
 Press 'k' to switch Konus on and off
 Move your mouse to rotate the coordinateSystem and both Shapes
 */


Konus k;
Zylinder z;
CoordinateSystem xyz;
boolean zon = true, kon = false;

void setup()
{
  size(800, 800, P3D);
  background(255);
  surface.setResizable(false);
  

  /*
  coordinateSystem:
   */
  
  xyz = new CoordinateSystem();

  /*
  Konus:
   segments, radius, height
   */
  k = new Konus(30, 100, 400);

  /*
  Zylinder:
   segments, radius, height,rings
   */
  z= new Zylinder(30, 100, 400, 10);
  z.setRings(5);
}

void draw()
{
  lights();
  translate(width/2, height/2);
  /*
  render Coordinate System:
   */
  xyz.setRotation(map(mouseY, 0, height, -PI, PI), map(mouseX, 0, width, -PI, PI), 0);
  xyz.renderShape();

  /*
render Zylinder if on:
   */
  if (zon)
  {
    z.setRotation(map(mouseY, 0, height, -PI, PI), map(mouseX, 0, width, -PI, PI), 0);
    z.renderShape();
  }

  /*
render Konus if on:
   */
  if (kon)
  { 
    k.setRotation(map(mouseY, 0, height, -PI, PI), map(mouseX, 0, width, -PI, PI), 0);
    k.renderShape();
  }
}

void keyPressed()
{
  /*
  switch to turn render of shapes on and off
   */
  if (key == 'z')
  {
    zon = !zon;
  }

  if (key == 'k')
  {
    kon = !kon;
  }
}