class RedSpaceShip extends SpaceShip {
/*
this class represents the RedSpaceShip
*/
  RedSpaceShip(GameManager gameManager) {
    /* 
    call the constructor of the superclass
    set object attributes
    */
    super(gameManager);
    super.fillColor = color(255, 0, 0);
    super.position = new PVector(width/2, height/2 -300);
    super.size = new PVector(80,80);
    super.orientation = radians(90);
  }

  /*
    event handling
   */

  void handleKey(char code) {
    // call this method of superclass
    super.handleKey(code);
    
    /*
    press w to set speed 1 and move toward orientation
    press s to stop
    press d to turn right
    press a to turn left
    press y to shoot
    */
   
    if( key == 'w')
    {
      super.speed = 3;
    }
    else if( key == 's')
    {
      super.speed = 0;
    }
    else if( key == 'a')
    {
      super.toggleleft = !super.toggleleft;
      super.toggleright= false;
      //orientation += radians(10);    
    }
    else if( key == 'd')
    {  
      super.toggleright = !super.toggleright;
      super.toggleleft = false;
    }
    
    else if( key == 'y')
    {
     Bullet b = new Bullet(gameManager, super.fillColor, super.position, super.orientation);
    }
    
  }

  void handleKeyCode(int code) {
    // call thisod of superclass
    super.handleKeyCode(code);
    // .. implement me ...
  }
}