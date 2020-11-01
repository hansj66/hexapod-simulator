import controlP5.*;

ControlP5 cp5;

String textValue = "";

void setup_controls() {
 
  PFont font = createFont("arial",20);
  
  cp5 = new ControlP5(this);
  
  cp5.addBang("TargetLeft")
     .setPosition(100,100)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    

  cp5.addBang("TargetRight")
     .setPosition(240,100)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    

  cp5.addBang("TargetForward")
     .setPosition(170,150)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  cp5.addBang("TargetReverse")
     .setPosition(170,50)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  
  cp5.addBang("TestUP")
     .setPosition(350,100)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  cp5.addBang("Solve")
     .setPosition(450,100)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  cp5.addBang("Reset")
     .setPosition(550,100)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  cp5.addBang("Rotate")
     .setPosition(550,150)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  cp5.addBang("Stop")
     .setPosition(550,200)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    

    
    
  textFont(font);
}

void Rotate(int value)
{
  if (value == 1)
  {
      rotationZ_delta =0.002;
      rotationX = radians(45);
  }
}

void Stop(int value)
{
  if (value == 1)
  {
      rotationZ_delta =0;
  }
}

void Reset(int value)
{ 
  rotationZ = 0;
  if (value == 1)
  {
    initialize_base_geometry();
    refresh_leg_geometry();
    for (int i=0; i<legs; i++)
    {
      effector_targets[i] = effector_origins[i].copy();
    }
  }
}

void Solve(int value)
{
  if (value == 1)
  {
    solve(0);
  }
}

void TestUP(int value)
{
  if (value == 1)
  {
    leg_up(0);
  }
}


void TargetLeft(int value)
{
  if (value == 1)
  {
    for (int i=0; i<legs; i++)
    {
      effector_targets[i].x -= 10;
    }
  }
}

void TargetRight(int value)
{
  if (value == 1)
  {
    for (int i=0; i<legs; i++)
    {
      effector_targets[i].x += 10;
    }
  }
}


void TargetForward(int value)
{
  if (value == 1)
  {
    for (int i=0; i<legs; i++)
    {
      effector_targets[i].y += 10;
    }
  }
}

void TargetReverse(int value)
{
  if (value == 1)
  {
    for (int i=0; i<legs; i++)
    {
      effector_targets[i].y -= 10;
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}
