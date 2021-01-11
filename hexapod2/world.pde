PShape floor;

float floor_Z = 0;

void initWorld(float z)
{
  floor = createShape(RECT,0, 0,width*2,height*2);
  floor.setStroke(color(128));
  floor.setStrokeWeight(4);
  floor.setFill(color(30));
  floor_Z = z;
  
  lightSpecular(255, 255, 255);
  directionalLight(204, 204, 204, 0, 0, -1);

}

void drawWorld()
{
  pushMatrix();
  translate(-width,-height, floor_Z);
  shape(floor);
  popMatrix();
}
