import controlP5.*;

void setup() {
  size(700, 700, P3D);
  
  floor_Z = initialize_geometry();
  init_floor(floor_Z);

  setup_controls();
}

float rotationZ = 0;
float rotationZ_delta = 0;
float rotationX =radians(0) ;
void draw() 
{
  pushMatrix();
  background(0);
  translate(width/2, height/2, -width/2);
  
  rotateX(radians(45));
  rotateZ(rotationZ);
  rotationZ+= rotationZ_delta;
  stroke(255);

  draw_robot();
  draw_floor();
  
  popMatrix();
}
