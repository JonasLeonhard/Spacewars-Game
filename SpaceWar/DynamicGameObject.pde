/*
 Author:  Knut Hartmann     knut.hartmann@hs-flensburg.de 
 Introduction to Computer Graphics
 Flensburg University of Applied Sciences, Germany
 
 DO NOT modify this class! 
 
 Implement your game logic in subclasses of GameManager (global game logic)
 and DynamicGameObject (rendering of the geometry and class specific game logic). 
 
 Date: November 1, 2017
 */

class DynamicGameObject extends GameObject {

  public float maxSpeed = 3.0;
  public float speed = 0.0;

  DynamicGameObject(GameManager gameManager) {
    // call the constructor of the superclass 
    super(gameManager);
  }

  /*
  debug output
   */

  public void debugInfo() {
    // call this method of superclass
    super.debugInfo();

    // display values of class attributes
    println("\t speed: " + speed);
  }

  /*
  Visual debugging:
   Transformations are also applied to visual debugging objects!
   Hence, use model coordinates!!
   */

  /*
   Visualize the heading direction of moving objects:
   extend the heading direction and draw a line and an end point.
   */

  private void renderHeadingVector() {
    if (speed > 0.0) {
      float vectorLength = 40.0;
      // determine heading according to the orientation (an angle) 
      PVector heading = new PVector(cos(orientation), sin(orientation));

      heading.setMag(vectorLength); // extend length of the line

      strokeWeight(1.0);
      stroke(0);
      line(0, 0, heading.x, heading.y);
      // an dummy arrow at the end point
      strokeWeight(5.0);
      point(heading.x, heading.y);
    }
  }

  public void renderOverlayDebugInfo() {
    // call this method of superclass
    super.renderOverlayDebugInfo();
    renderHeadingVector();
  }

  /*
  movement
   */

  public void moveTowards(float angle, float speed) {
    // determine heading according to the orientation (an angle) 
    PVector heading = new PVector(cos(angle), sin(angle));
    heading.setMag(speed);
    position.add(heading);
  }

  /*
   Determine a new random direction and modify the current heading direction.
   The dumping factor determines the influence of the new direction 
   onto the old steering direction.
   */

  public void moveRandom(float dampingFactor) {    
    // determine a random direction
    PVector direction = PVector.random2D();
    // scale the random vector according to a percentage influence value
    direction.normalize();
    direction.setMag(dampingFactor);

    // determine the heading direction according to the orientation (an angle) 
    PVector heading = new PVector(cos(orientation), sin(orientation));
    heading.setMag(1.0 - dampingFactor);

    // combine heading direction and random variation
    heading.add(direction);
    heading.normalize();
    heading.setMag(speed);
    position.add(heading);

    // determine a new orientation according to the resulting vector
    orientation = atan2(heading.y, heading.x);
  }

  /*
    DO NOT leave the canvas
   */

  void stayInsideCanvas() {
    if (position.x < -size.x) {
      position.x = width;
    }
    if (position.x > width) {
      position.x = - size.x;
    }
    if (position.y < -size.y) {
      position.y = height;
    }
    if (position.y > height) {
      position.y = -size.y;
    }
  }

  /*
  Called within the game loop.
   Subclasses should override this function 
   in order to update their internal status.
   */

  public void update() {
    // call this method of superclass
    super.update();
    moveTowards(orientation, speed);
    speed = constrain(speed, 0, maxSpeed);
  }
}