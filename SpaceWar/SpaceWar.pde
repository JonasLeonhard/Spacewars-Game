// the main program
// feel free to modify everything

GameManager gameManager;

/*
  initialize the game
 */

void setup() {
  size(800, 800, P3D);
  surface.setResizable(true);


  PFont debugFont = createFont("Helvetica", 14);
  textFont(debugFont);

  // the overall game logic that manages all game objects 
  gameManager = new GameLogic();
  // activate collision detection
  gameManager.collisionMode = CollisionDectectionMode.BOUNDING_SPHERE;

  SpaceShip ship1 = new RedSpaceShip(gameManager);
  //ship1.fillColor = color(255, 0, 0);

  SpaceShip ship2 = new BlueSpaceShip(gameManager);
  //ship2.fillColor = color(0, 0, 255);
}

/*
  called every frame
 */

void draw() {
  background(240);
  gameManager.runGameLoopCycle();
}

/*
  event handling
 */

void keyPressed() {
  gameManager.handleKey(key);
  gameManager.handleKeyCode(keyCode);
}

void mousePressed() {
  gameManager.handleMousePressed(mouseX, mouseY);
}