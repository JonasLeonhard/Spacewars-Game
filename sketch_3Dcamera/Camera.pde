class Camera {

  PVector eye, up, center;
  float distance = 2000;
  float orthodist = 500;
  int keyint = 0;
  boolean ortho = true; //ortho is default view

  Camera(float eyeX, float eyeY, float eyeZ, 
    float centerX, float centerY, float centerZ, 
    float upX, float upY, float upZ)
  {

    //ortho(); //camera view:t
    //perspective();

    this.eye = new PVector(eyeX, eyeY, eyeZ);
    this.center = new PVector(centerX, centerY, centerZ);
    this.up = new PVector(upX, upY, upZ);
  }

  void view()
  {
    if (ortho)
    {
      ortho(-width-orthodist, width+orthodist, -height-orthodist, height+orthodist);
    }
    camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z);
  }

  void keyPressed()
  {
    if (key == 'o')
    {  
      ortho = true;
    }

    if (key == 'p')
    {
      ortho = false;
      perspective();
    }
    /*
     checks for keys 1,2,3,4,+,- 
     sets the eye of the camera accordingly
     */
    if (key == '1')
    {
      /*
      Vorderansicht:
       */
      eye = new PVector(0, 0, distance);
      keyint = 1;
    }
    if (key == '2')
    {
      /*
       Seitenansicht:
       */
      eye = new PVector(distance, 0, 0);
      keyint = 2;
    }
    if (key == '3')
    {
      /*
       Draufsicht:
       */
      eye = new PVector(0, -distance, 1);
      keyint = 3;
    }
    if (key == '4')
    {
      /*
      Isometrisch:
       */
      eye = new PVector(-1600, -1600, distance);
      keyint =4;
    }

    ////////////////////////////////////////////////////////////
    if (key =='+' && !ortho)
    {
      /*
      zoom:
       */
      distance -= 100;

      /*
      check for last view:
       */
      if (keyint == 1 || keyint == 0)
      {
        eye = new PVector(0, 0, distance);
      }
      if (keyint == 2)
      {
        eye = new PVector(distance, 0, 0);
      }
      if (keyint == 3)
      {
        eye = new PVector(0, -distance, 1);
      }
      if (keyint == 4 )
      {
        eye = new PVector(-1600, -1600, distance);
      }
    }

    /////////////////////////////////////////////////////////
    if (key =='-' && !ortho)
    {
      /*
      zoom out:
       */
      distance += 100;

      /*
      check for last view:
       */
      if (keyint == 1 || keyint == 0)
      {
        eye = new PVector(0, 0, distance);
      }
      if (keyint == 2)
      {
        eye = new PVector(distance, 0, 0);
      }
      if (keyint == 3)
      {
        eye = new PVector(0, -distance, 1);
      }
      if (keyint == 4)
      {
        eye = new PVector(-1600, -1600, distance);
      }
    }
    ///////////////////////////////////////////////////////////////
    
    /*
    ortho camera zoom in and out:
    */
    if (key == '-' && ortho)
    {
      orthodist += 100;

      ortho(-width-orthodist, width+orthodist, -height-orthodist, height+orthodist);
    }

    if (key == '+' && ortho)
    {
      orthodist -= 100;

      ortho(-width-orthodist, width+orthodist, -height-orthodist, height+orthodist);
    }
  }
}