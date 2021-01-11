void setup() {
  size(700, 700, P3D);
  background(0);

  initializeGeometry();
 
  initializeTargetPositions(50, -50, 0);
  
  lift(0);
  //lift(2);
  //lift(4);
  
}

float zrot = 0;
void updateView()
{
  //float ry = map(mouseX, 0, width, 0, TWO_PI); 
  //float rx = map(mouseY, 0, height, 0, TWO_PI); 
  //rotateY(ry);
  //rotateX(rx);
  rotateY(radians(0));
  rotateX(radians(180));
//  print("X:");
//  println(rx);
//  print("Y:");
//  println(ry);
  rotateZ(zrot);
}

void draw() 
{
  //zrot += 0.04;
  clear();
  pushMatrix();
  translate(width/2, height/2, 0);
  updateView();
  drawRobot();
  drawWorld();
  drawTargets();
  solve();
  popMatrix();
}
