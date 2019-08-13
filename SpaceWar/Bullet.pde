class Bullet extends DynamicGameObject {
  /*
  this class represents a Bullet
  */
public ArrayList<PVector> bshape = new ArrayList<PVector>();

  color c;
  PVector position;
  float orientation;
  int missilespeed = 4;

  Bullet(GameManager gameManager, color fill, PVector pos, float orientation) {
    // call the constructor of the superclass
    super(gameManager);
   
    /*
    The Shape of the Bullet:
    */
    bshape.add(new PVector(-1.5,-10));
    bshape.add(new PVector(-1.5,10));
    bshape.add(new PVector(1.5,10));
    bshape.add(new PVector(1.5,-10));
    
    /*
    Attributes to save / to set in superclass
    */
    this.c = fill;
    this.position = new PVector(pos.x, pos.y);
    this.orientation = orientation;
    
    super.size = new PVector(25,3);
    super.fillColor = this.c;
    super.position = this.position;
    super.orientation =this.orientation;
    
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
    set missile Speed
    check collision
    remove if out of bounds
    */
    super.speed = missilespeed; //missile speed
    
    collidesWith(this);
    bulletinsidebounds();
    
  }

  /*
   This method is called by the gameManager when this object
   collides with another GameObject (object).
   Often the response depends on the class of the colliding object.
   */
   
  void bulletinsidebounds()
  {
    if(this.position.x <0 || this.position.x > width)
    {
      gameManager.removeObject(this);
    }
    
    if(this.position.y <0 || this.position.y > height)
    {
     gameManager.removeObject(this);
    }
  }
  @Override
  void collidesWith(GameObject object) {
    
    /*
    check if this bullet collides with any other object in the gamObjects array list. 
    If yes: remove the object
    */
    
    
    
      //check if its the same color
      if(this.c != object.fillColor)
      {
        gameManager.removeObject(this);
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

  void renderShape() {
    /*
    draws the Bullet from ist Vector list bshape:
    rotate to match its orientation
    */
    noStroke();
    rotate(radians(-90));
    fill(fillColor);
    beginShape();
    
      for(PVector v : bshape)
      {
        vertex(v.x,v.y);
      }
    
    endShape();
  }
  
  
}