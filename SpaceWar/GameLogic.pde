// a placeholder for your overall game logic 
// typically you send messages to ALL game objects
// the 'standard' game logic is done by the GameManager class

class GameLogic extends GameManager {
  int shipvelocity;
  int hitpoints = 3;

  void handleMousePressed(float x, float y) {
    // call this method of superclass
    super.handleMousePressed(x, y);
    // .. implement me ...
  }

  // toggle between static and animated status
  boolean frozen = false;

  void handleKey(char code) {
    super.handleKey(code);

    // you may use or delete this code 
    if (code == 'f') {
      // toggle animation mode
      frozen = !frozen;

      if (frozen) {
        noLoop();
      } else {
        loop();
      }
      
    }

    // .. implement me ...
  }

  void handleKeyCode(int code) {
    super.handleKeyCode(code);
    // .. implement me ...
  }
  
  public void removeHitPoint()
  {
    if(hitpoints >= 1)
    {
    hitpoints--;
    } else if(hitpoints == 0)
    {
      //gameover this.color has lost the game::
    }
  }
}