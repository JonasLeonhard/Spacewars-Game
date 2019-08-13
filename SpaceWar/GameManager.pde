/*
 Author:  Knut Hartmann     knut.hartmann@hs-flensburg.de 
 Introduction to Computer Graphics
 Flensburg University of Applied Sciences, Germany
 
 DO NOT modify this class! 
 
 Implement your game logic in subclasses of GameManager (global game logic)
 and DynamicGameObject (rendering of the geometry and class specific game logic). 
 
 Date: November 1, 2017
 */

public enum CollisionDectectionMode { 
  NONE, AABB, BOUNDING_SPHERE
};

class GameManager {

  public boolean debugMode = true;

  /*
    specify which bounding object / algorithm is used to detect collisions
   */

  public CollisionDectectionMode collisionMode = CollisionDectectionMode.BOUNDING_SPHERE;

  /*
   The container gameObjects store all game objects. 
   DO NOT modify this container directly!
   Use the methods addObject or removeObject instead!
   */

  public ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

  /*
    Auxiliary container to safely manipulate the gameObjects container
   used by the addObject and removeObject methods.
   */

  private ArrayList<GameObject> addList = new ArrayList<GameObject>();
  private ArrayList<GameObject> removeList = new ArrayList<GameObject>();

  /*
  management of new and removed game objects
   */

  public void addObject(GameObject object) {
    addList.add(object);
  }

  public void removeObject(GameObject object) {
    removeList.add(object);
  }

  /*
    We activate each game object in the game loop.
   Hence, we must not alter this list directly in the render / update methods
   as it would rsult in strange errors (run out of index in the ArryList).
   New game objects are added and old game objects are removed in the 
   NEXT cycle of the game loop!
   */

  private void updateGameObjects() {
    // addObjects
    for (GameObject object : addList) {
      gameObjects.add(object);
    }
    addList.clear();
    // deleteObjects
    for (GameObject object : removeList) {
      gameObjects.remove(object);
    }
    removeList.clear();
  }

  /*
  debug output
   */

  public void debugInfo() {
    fill(0);
    textAlign(LEFT, BASELINE);
    text("objects: " + gameObjects.size(), 5, 15);

    String mode = "";
    switch (collisionMode) {
    case NONE:
      mode = "NONE";
      break;
    case BOUNDING_SPHERE:
      mode = "Bounding Sphere";
      break;
    case AABB:
      mode = "Axis-Aligned Bounding Box";
    }
    text("collision mode: " + mode, 5, 30);
  }

  /*
  the game loop
   */

  public void runGameLoopCycle() {
    if (debugMode) { 
      debugInfo();
    }

    // modify the game object container (i.e., notifications to add and remove game objects)
    // before updating and rendering
    updateGameObjects();

    for (GameObject object : gameObjects) {
      object.update();
      // every GameObject might have some visual debugging 
      // called in the render method
      object.render();
    }

    /*
    colliding game objects receive a notifcation:
     o1.collidesWith(o2);
     o2.collidesWith(o1);
     implement game logic to react to collisions 
     in own classed derived from GameObject.
     */
    detectCollisions();
  }

  /*
  Interaction
   */

  public void handleKey(char code) {
    if (code == 'D') {
      debugMode = !debugMode;
    }

    if (code == 'i') {
      println("\nStatus report:");
      println("# game objects: " + gameObjects.size());
      for (GameObject gameObject : gameObjects) {
        gameObject.debugInfo();
      }
    }

    for (GameObject object : gameObjects) {
      object.handleKey(code);
    }
  }

  public void handleKeyCode(int code) {
    for (GameObject object : gameObjects) {
      object.handleKeyCode(code);
    }
  }

  public void handleMousePressed(float x, float y) {
    for (GameObject object : gameObjects) {
      object.handleMousePressed(x, y);
    }
  }

  /*
  Collision Detection: These algorithms are subject of a lecture 
   in the next term:  Game Programming (Spieleprogrammierung).
   Therefore, NO EXPLANATION ... it's just mystic.
   */

  void detectBundingSphereCollisions() {
    for (int i = 0; i < gameObjects.size (); i++) {
      GameObject o1 = gameObjects.get(i);
      for (int j = i + 1; j < gameObjects.size (); j++) {
        GameObject o2 = gameObjects.get(j);
        float midPointDistance =  PVector.dist(o1.position, o2.position);
        float distance = midPointDistance - o1.radius - o2.radius;
        //println("distance(o" + o1.getID() + ",o" + o2.getID() + "): " + distance);
        if ((o1 != o2) && (distance <= 0)) {
          o1.hit = true;
          o1.collidesWith(o2);
          o2.hit = true;
          o2.collidesWith(o1);
        }
      }
    }
  }

  // separating axis theorem on the x axis
  boolean separatingX(GameObject o1, GameObject o2) {
    // boundaries of object o1
    float o1Left = o1.position.x - o1.size.x/2;
    float o1Right = o1.position.x + o1.size.x/2;
    // boundaries of object o2
    float o2Left = o2.position.x - o2.size.x/2;
    float o2Right = o2.position.x + o2.size.x/2;
    // o2 is right to o1 and there is a horizontal gap between o1 and and o2
    boolean o2LeftToO1 = (o2Left <= o1Left) && (o2Right < o1Left);
    // o2 is left to o1 and there is a gap horizontal between o1 and and o2
    boolean o2RightToO1 = (o2Right >= o1Right) && (o2Left > o1Right);
    return (o2LeftToO1 || o2RightToO1);
  }

  boolean separatingY(GameObject o1, GameObject o2) {
    // boundaries of object o1
    float o1Top = o1.position.y - o1.size.y/2;
    float o1Bottom = o1.position.y + o1.size.y/2;
    // boundaries of object o2
    float o2Top = o2.position.y - o2.size.y/2;
    float o2Bottom = o2.position.y + o2.size.y/2;
    // o2 is below o1 and there is a vertical gap between o1 and and o2
    boolean o2AboveToO1 = (o2Top <= o1Top) && (o2Bottom < o1Top);
    // o2 is above o1 and there is a vertical gap between o1 and and o2
    boolean o2BelowToO1 = (o2Bottom >= o1Bottom) && (o1Bottom < o2Top);
    return (o2AboveToO1 || o2BelowToO1);
  }

  void detectAABBCollisions() {
    for (int i = 0; i < gameObjects.size (); i++) {
      GameObject o1 = gameObjects.get(i);
      for (int j = i + 1; j < gameObjects.size (); j++) {
        GameObject o2 = gameObjects.get(j);
        if ((o1 != o2) && !separatingX(o1, o2) && !separatingY(o1, o2)) {
          //println("hit: " + o1.getID() + " <-> " + o2.getID());
          o1.hit = true;
          o1.collidesWith(o2);
          o2.hit = true;
          o2.collidesWith(o1);
        }
      }
    }
  }

  void detectCollisions() {
    // clear the hit flag     
    for (GameObject gameObject : gameObjects) {
      gameObject.hit = false;
    }

    switch (collisionMode) {
      //case CollisionDectectionMode.AABB: 
    case AABB: 
      detectAABBCollisions();
      break;

      //case CollisionDectectionMode.BOUNDING_SPHERE :
    case BOUNDING_SPHERE :
      detectBundingSphereCollisions();
      break;

      //case CollisionDectectionMode.NONE:
    default:
    }
  }
}