/*
 Author:  Knut Hartmann     knut.hartmann@hs-flensburg.de 
 Introduction to Computer Graphics
 Flensburg University of Applied Sciences, Germany
 
 DO NOT modify this class! 
 
 Implement your game logic in subclasses of GameManager (global game logic)
 and DynamicGameObject (rendering of the geometry and class specific game logic). 
 
 Date: November 1, 2017
 */

class GameObject {

  // we need to get on the list of game objcets
  protected GameManager gameManager;

  // users can select objects -> different behaviours
  public boolean selected = false;
  public boolean hit = false;

  /*
  screen coordinates
   unit: pixel
   */

  //  dimensions of the bounding rectangle
  public PVector size = new PVector();
  // radius of the bounding sphere -- used in collision detection
  protected float radius = 0.0;

  public PVector position = new PVector();
  // the heading direction (an angle)
  public float orientation = 0.0;

  public color fillColor = color(0);

  /*
  constructor
   */

  GameObject(GameManager gameManager) {
    // Store a reference to game manager 
    // as we might want to add or remove game objects during the game.
    this.gameManager = gameManager;
    // Add game object itself into a list of active game objects
    // managed by the gameManager.
    gameManager.addObject(this);
  }

  /*
   Determine an unique ID: the index in the list of game objects.
   The indicies starts at 0, but humans start counting with 1.
   */

  public int getID() {
    return gameManager.gameObjects.indexOf(this) + 1;
  }

  /*
    debug output
   */

  public void debugInfo() {
    // display values of class attributes
    println("\nGameObject: " + getID()); 
    println("\t selected: " + selected + "\t hit: " + hit);
    println("\t position: (" + round(position.x) + " " + round(position.y) + ")");
    println("\t orientation: " + degrees(orientation));
    println("\t size: (" + round(size.x) + " " + round(size.y) + ")");
    println("\t radius: " + radius);
  }

  /*
  visual debugging
   */

  private void renderBoundingSphere() {
    color hitColor = color(200, 0, 100);
    color selectColor= color(255, 255, 150);
    color strokeColor = color(0, 200, 200);

    strokeWeight(1.0);
    stroke(strokeColor);
    // visualize status information
    if (hit) {
      fill(hitColor);
    } 
    if (selected) {
      fill(selectColor);
    } else {
      noFill();
    }

    // reference point = origin of the model coordinate system
    // the model has to be CENTERED (horizontal) and CENTERED (vertical).
    ellipseMode(RADIUS);
    ellipse(0, 0, radius, radius);
  }

  private void renderObjectID() {
    fill(0); // text color
    textSize(12);
    textAlign(CENTER, BOTTOM);
    float yOffset = -3.0;
    text(getID(), 0, -size.y/2 + yOffset);
  }

  private void renderBoundingBox() {
    color bbColor = color(200, 200, 0);

    /*
    Draw a bounding box around the shape for visual debugging.
     reference point = origin of the model coordinate system
     is CENTERED (horizontal) and CENTERED (vertical). 
     The rectMode adjust the reference point of the bounding rectangle.
     */
    strokeWeight(1.0);
    stroke(bbColor);
    noFill();
    rectMode(CENTER);
    rect(0, 0, size.x, size.y);
  }

  private void renderReferencePoint() {
    color rpColor = color(200, 0, 0);
    float rpSize = 5.0;

    strokeWeight(rpSize);
    stroke(rpColor);
    fill(rpColor);
    point(0, 0);
  }

  /*
    Transformations are also applied to visual debugging objects!
   Hence, use model coordinates!!
   */

  public void renderBackgroundDebugInfo() {
    renderBoundingSphere();
    renderBoundingBox();
    renderObjectID();
  }

  public void renderOverlayDebugInfo() {
    renderReferencePoint();
  }

  /*  
   The render method is called within the game loop.
   It transforms model coordinates into screen coordinates.
   
   Subclasses should override the renderShape method
   in order to draw their geometry and the renderDebugInfo method 
   for visual debugging.
   */

  public void renderShape() {
    //  subclasses should override this function
    println("renderShape: no geometry");
  }
 
  public void render() { 
    pushMatrix();
    translate(position.x, position.y);

    // do NOT rotate debug overlay information
    pushMatrix();

    rotate(orientation);

    if (gameManager.debugMode) { 
      renderBackgroundDebugInfo();
    }

    renderShape();

    // do NOT rotate debug overlay information
    popMatrix();

    if (gameManager.debugMode) { 
      renderOverlayDebugInfo();
    }
    popMatrix();
  }


  /*
  Called within the game loop.
   Subclasses should use this function in order to update their internal status.
   We determine the radius of the bounding sphere according to the size of the 
   bounding rectangle.
   */

  public void update() {
    radius = sqrt(size.x/2 * size.x/2 + size.y/2 * size.y/2);
  }

  /*
  user interaction: is a given point inside the bounding sphere?
   */

  public boolean isInside(float x, float y) {   
    // Is the point (x, y) inside the bounding sphere of the game object?
    PVector aPosition = new PVector(x, y);
    float distance = PVector.dist(position, aPosition);
    return (distance <= radius);
  }

  /*
    event handling methods:
   - user can select objects by mouse clicks 
   */

  public void handleKey(char code) {
    // override this method
  }

  public void handleKeyCode(int code) {
    // override this method
  }

  /*
   A typical application is to test whether the user has selected
   any game object by mouse and do something cool if there game object on the mouse location.
   */

  public void handleMousePressed(float x, float y) {
    // (de-)select game objects 
    if (isInside(x, y)) {
      selected = !selected;
    }
  }

  /*
  reactions to collisions
   */

  void collidesWith(GameObject object) {
    // override this method
  }
}