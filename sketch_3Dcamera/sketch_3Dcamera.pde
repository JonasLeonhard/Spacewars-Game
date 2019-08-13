
/*
Author Jonas Leonhard
 This Program creates a Scene that explodes from the Worlds Center (0,0,0). 
 It creates a Coordinate System on (0,0,0). 
 Around it it creates Shapes on a Circle
 Each Object shows its own CoordinateSystem in ints World Origin Point.
 The Programm implements a Camera that can switch between ortho and perspective mode
 
 CONTROLS:
 Press 'z' to switch Zylinder on and off
 Press 'k' to switch Konus on and off
 Press 1,2,3,4 to change camera view
 Press +, - to zoom in and out
 Press SPACE to make Scene explode from Center
 Press x to reset Scene
 Press o for ortho view
 Press p for perspective view
 */


Konus k;
Zylinder z;
CoordinateSystem xyz;
boolean zon = true, kon = true;
boolean explode = false;

int tX = 0;
int tY = 0;

Camera cam;
ArrayList<Zylinder> zylinders;
ArrayList<Konus> konus;




void setup()
{

  size(800, 800, P3D);
  background(255);
  surface.setResizable(false);
  defaultScene();

  /*
  Camera: initial view:
   */ 
  PVector eye = new PVector(0, 0, 2000); 
  PVector center = new PVector(0, 0, 0); 
  PVector up = new PVector(0, 1, 0);
  cam = new Camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, 
    up.x, up.y, up.z);
}

void draw()
{
  background(255);
  lights();
  cam.view();
  renderScene();
}

void defaultScene()
{
  /*
  coordinateSystem:
   */
  zylinders = new ArrayList<Zylinder>();
  konus = new ArrayList<Konus>();
  xyz = new CoordinateSystem();

  /*
  create objects to render in loop - put them in render list shapes:
   */

  for (int i = 0; i <= 10; i++)
  {
    //pushMatrix();

    Zylinder z = new Zylinder(30, 50, 200, 10);
    zylinders.add(z);
    // popMatrix();
  }

  for (int i = 0; i <= 10; i++)
  {
    //pushMatrix();

    Konus k = new Konus(30, 60, 200);
    konus.add(k);
    // popMatrix();
  }
}

void renderScene()
{
  /*
  render Coordinate System in the midlle of world coordinates:
   */
  xyz.renderShape();

  /*
render Zylinder if on:
   */
  if (zon)
  { 



    for (int i = 0; i< zylinders.size(); i++)
    {
      Zylinder z = zylinders.get(i);

      if (!explode)
      {
        tX =  (int)(0+700*cos(i));
        tY =  (int)(0+700*sin(i));
        z.setX(tX);
        z.setY(tY);
      }

      if (explode)
      {

        z.position.x += z.position.x /10;
        z.position.y += z.position.y / 10;
      }

      pushMatrix();
      translate(z.position.x, z.position.y);
      z.renderShape();
      z.renderCoordinateSystem();
      popMatrix();
    }
  }

  /*
render Konus if on:
   */
  if (kon)
  { 



    for (int i = 0; i< konus.size(); i++)
    {
      Konus k = konus.get(i);
      if (!explode)
      {
        tX =  -(int)(0+700*cos(i));
        tY =  -(int)(0+700*sin(i));
        k.setX(tX);
        k.setY(tY);
      }

      if (explode)
      {
        k.position.x += k.position.x /10;
        k.position.y += k.position.y / 10;
      }
      pushMatrix();
      translate(k.position.x, k.position.y);
      k.renderShape();
      k.renderCoordinateSystem();
      popMatrix();
    }
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

  if (key == ' ')
  {
    /*
    trigger explode:
     */
    explode = true;
  }

  if (key == 'x')
  {
    /*
    default scene
     */
    explode = false;
    zylinders.clear();
    konus.clear();
    defaultScene();
  }

  //////////////////
  //handle camkeys:
  /////////////////
  cam.keyPressed();
}