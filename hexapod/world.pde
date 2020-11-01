PShape floor;

float floor_Z = 0;

void init_floor(float z)
{
  floor = createShape(RECT,0, 0,width*2,height*2);
  floor.setStroke(color(128));
  floor.setStrokeWeight(4);
  floor.setFill(color(30));
}

void draw_floor()
{
  pushMatrix();
  translate(-width,-height, floor_Z);
  shape(floor);
  popMatrix();
}
