class BlueSpaceShip extends SpaceShip {

  BlueSpaceShip(GameManager gameManager) {
    // call the constructor of the superclass
    super(gameManager);
    super.fillColor = color(0, 0, 255);
    super.position = new PVector(width/2 , height/2 +250);
    super.size = new PVector(80,80); 
    super.orientation = radians(-90);
  }

  /*
    event handling
   */

  void handleKey(char code) {
    // call this method of superclass
    
    
    super.handleKey(code);
    // .. implement me ...
  }

  void handleKeyCode(int code) {
    // call this method of superclass
    super.handleKeyCode(code);
    
    /*
    press UP to set speed 1 and move toward orientation
    press DOWN to stop
    press LEFT to turn right
    press RIGHT to turn left
    press SPACE to shoot
    */
     if( code == UP)
    {
      super.speed = 3;
    }
    else if( code == DOWN)
    {
      super.speed = 0;
    }
    else if( code == LEFT)
    {
      super.toggleleft = !super.toggleleft;
      super.toggleright= false;   
    }
    else if( code == RIGHT)
    {  
      super.toggleright = !super.toggleright;
      super.toggleleft = false;
    }
    
    else if( key == ' ')
    {
     Bullet b = new Bullet(gameManager, super.fillColor, super.position, super.orientation);
    }
  }
}