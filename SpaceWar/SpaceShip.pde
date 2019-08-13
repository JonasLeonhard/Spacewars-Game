class SpaceShip extends DynamicGameObject {

  public ArrayList<PVector> shape = new ArrayList<PVector>();

  int ytrans = -5;
  int velocity = 10;
  boolean toggleleft = false;
  boolean toggleright = false;
  boolean togglehit = false;
  int hitpoints = 10;


  SpaceShip(GameManager gameManager) {  
    // call the constructor of the superclass
    super(gameManager);

    //these are used to construct spaceship:
    shape.add(new PVector(0, 45 +ytrans));
    shape.add(new PVector(5, 25+ytrans));
    shape.add(new PVector(5, 5+ytrans));
    shape.add(new PVector(7.5, 5+ytrans));
    shape.add(new PVector(7.5, 10+ytrans));
    shape.add(new PVector(10, 10+ytrans));
    shape.add(new PVector(10, 5+ytrans));
    shape.add(new PVector(10, -5+ytrans));
    shape.add(new PVector(20, -10+ytrans));
    shape.add(new PVector(30, -5+ytrans));
    shape.add(new PVector(30, 5+ytrans));
    shape.add(new PVector(25, 25+ytrans));
    shape.add(new PVector(40, 5+ytrans));
    shape.add(new PVector(40, -5+ytrans));
    shape.add(new PVector(35, -15+ytrans));
    shape.add(new PVector(20, -20+ytrans));
    shape.add(new PVector(10, -25+ytrans));
    shape.add(new PVector(7.5, -25+ytrans));
    shape.add(new PVector(7.5, -35+ytrans));
    shape.add(new PVector(2.5, -35+ytrans));
    shape.add(new PVector(2.5, -25+ytrans));
    shape.add(new PVector(0, -25+ytrans));
    shape.add(new PVector(-2.5, -25+ytrans));

    shape.add(new PVector(-2.5, -35+ytrans));
    shape.add(new PVector(-7.5, -35+ytrans));
    shape.add(new PVector(-7.5, -25+ytrans));
    shape.add(new PVector(-10, -25+ytrans));
    shape.add(new PVector(-20, -20+ytrans));
    shape.add(new PVector(-35, -15+ytrans));
    shape.add(new PVector(-40, -15+ytrans));
    shape.add(new PVector(-40, 5+ytrans));
    shape.add(new PVector(-25, 25+ytrans));
    shape.add(new PVector(-30, 5+ytrans));
    shape.add(new PVector(-30, -5+ytrans));
    shape.add(new PVector(-20, -10+ytrans));
    shape.add(new PVector(-10, -5+ytrans));
    shape.add(new PVector(-10, 5+ytrans));
    shape.add(new PVector(-10, 10+ytrans));
    shape.add(new PVector(-7.5, 10+ytrans));
    shape.add(new PVector(-7.5, 5+ytrans));
    shape.add(new PVector(-5, 5+ytrans));
    shape.add(new PVector(-5, 15+ytrans));
    shape.add(new PVector(-5, 25+ytrans));
  }

  /*
   The debugInfo method is called in the method runGameLoopCycle 
   of the GameManager class for every game object once per frame.
   Use it for debug information on the console.
   */

  public void debugInfo() {
    // call this method of superclass
    super.debugInfo();
    // .. implement me ...
  }

  /*
   The update method is called in the method runGameLoopCycle 
   of the GameManager class for every game object once per frame.
   */

  void update() {
    // call this method of superclass
    super.update();
    /*
    keeps spaceship inside canvas
     and switch boolean to turn spaceship orientation - is called in  key == a/d/left/right
     */

    stayInsideCanvas();

    if (toggleleft && !toggleright)
    {
      toggleright = false;
      orientation -= radians(3);
    }

    if (toggleright && !toggleleft)
    {
      toggleleft = false;
      orientation += radians(3);
    }

    //
    if (togglehit)
    {
      togglehit = false;
    }
  }

  /*
   This method is called by the gameManager when this object
   collides with another GameObject (object).
   Often the response depends on the class of the colliding object.
   */

  void collidesWith(GameObject object) 
  {
    //checkcollisionwithSpaceship();
    
    //bulletcollisiondetect:
    if (this.fillColor != object.fillColor)
      {

        //remove hitpoints upon beeing hit  
        if (hitpoints>= 2)
        { 
          hitpoints--;
        } else
        {
          hitpoints = 0;
          //gameover
          gameManager.removeObject(this);
        }
      }
  }

  void checkcollisionwithSpaceship()
  {
    /* 
     check for each spaceship if it collides with the other
     if both ships collide they get removed
     */

    //check if hit by other spaceship
    for (int i=0; i<=1; i++)
    {
      GameObject o2 = gameManager.gameObjects.get(i);
      float posdis = dist(position.x, position.y, o2.position.x, o2.position.y);

      if (posdis < this.radius + o2.radius && this != o2 && this.fillColor != o2.fillColor)
      {
        gameManager.removeObject(this);
      }
    }
  }

 
  
  /*
    The render method is called in the method runGameLoopCycle 
   of the GameManager class for every game object once per frame.
   The method render of the classes GameObject and DynamicGameObject 
   apply all transformations to convert model coordinates into screen coordinates.
   Then these methods calls several rendering methods:
   - renderShape: draw the geometry of your model
   - renderBackgroundDebugInfo: 
   - renderOverlayDebugInfo
   Use model coordinates with a reference point
   in the middle of your model!
   */

  void renderOverlayDebugInfo() {
    // call this method of superclass
    super.renderOverlayDebugInfo();
    // .. implement me ...
  }

    @Override
    public void renderShape() {
    /*
    draws the shape arraylist with all Vectors inside
     rotate to object orientation
     */

    noStroke();
    rotate(radians(-90));
    fill(fillColor);
    beginShape();

    for (PVector v : shape)
    {
      vertex(v.x, v.y);
    }

    endShape();
  }

  /*
    event handling
   */

  void handleKey(char code) {
    // call this method of superclass
    super.handleKey(code);
  }

  void handleKeyCode(int code) {
    // call this method of superclass
    super.handleKeyCode(code);
    // .. implement me ...
  }
}