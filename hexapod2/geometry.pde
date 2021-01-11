int legs = 6;

float cl = 45; // Coxa length      
float fl = 61.5; // Femur length   
float tl = 132; // Tibia length  

PVector[] co = new PVector[legs]; // Coxa origins
PVector[] fo = new PVector[legs]; // Femur origins
PVector[] to = new PVector[legs]; // Tibia origins
PVector[] eo = new PVector[legs]; // Effector origins

float[] ca = new float[] {70,0,290,250,180,110}; // Coxa angles

float[] fa = new float[] {45,45,45,45,45,45}; // Femur angles
float[] ta = new float[] {80,80,80,80,80,80,80}; // Tibia angles

PVector[] target = new PVector[legs];

void lift(int leg)
{
  fa[leg] = -45;
  ta[leg] = 130; 
  refreshGeometry();
}

void initializeGeometry()
{
  co[0] = new PVector(49,47,0);
  co[1] = new PVector(65.5,0,0);
  co[2] = new PVector(49,-47,0);
  co[3] = new PVector(-49,-47,0);
  co[4] = new PVector(-65.5,0,0);
  co[5] = new PVector(-49,47,0);
  
  for (int i=0; i<legs; i++)
  {
    fo[i] = new PVector();
    to[i] = new PVector();
    eo[i] = new PVector();
    target[i] = new PVector(); 
  }
  
  refreshGeometry();
  
  initWorld(eo[0].z);
}

void refreshGeometry()
{
  for (int i=0; i<legs; i++)
  {
    // Coxa
    fo[i].x = co[i].x + cl*cos(radians(ca[i]));
    fo[i].y = co[i].y + cl*sin(radians(ca[i]));
    fo[i].z = co[i].z;
  
    // femur
    float femur_projected_length = fl*cos(radians(fa[i]));
    to[i].x = fo[i].x + femur_projected_length*cos(radians(ca[i]));
    to[i].y = fo[i].y + femur_projected_length*sin(radians(ca[i]));
    to[i].z = fl*sin(radians(fa[i]));
    
    // Sanity check
    if (abs(sqrt( (fo[i].x-to[i].x)*(fo[i].x-to[i].x) +
                (fo[i].y-to[i].y)*(fo[i].y-to[i].y) + 
                (fo[i].z-to[i].z)*(fo[i].z-to[i].z) ) - fl) > 0.01)
    {
      println("Femur is broken...");
    }
    
    // Tibia
    float tibia_projected_length = tl*cos(radians(fa[i]+ta[i]));
    eo[i].x = to[i].x + tibia_projected_length*cos(radians(ca[i]));
    eo[i].y = to[i].y + tibia_projected_length*sin(radians(ca[i]));
    eo[i].z = tl*sin(radians(fa[i]+ta[i])) + to[i].z;
    
    // Sanity check
    if (abs(sqrt((to[i].x-eo[i].x)*(to[i].x-eo[i].x) +
                 (to[i].y-eo[i].y)*(to[i].y-eo[i].y) + 
                 (to[i].z-eo[i].z)*(to[i].z-eo[i].z)) - tl) > 0.01)
    {
      println("Tibia is broken...");
    }
  }
}

void drawBase()
{
  stroke(255);
  fill(64);

  beginShape();
  for (int i=0; i<legs; i++)
  {
    vertex(co[i].x, co[i].y, co[i].z);
  }
  endShape(CLOSE);
}

void drawJoint(float x, float y, float z, float size)
{
    pushMatrix();
    translate(x, y, z);
    sphere(size);
    popMatrix();
}

void drawRobot()
{
  drawAxis();
  drawBase();
  
  for (int i=0; i<legs; i++)
  {
    // Coxa
    line(co[i].x, co[i].y, co[i].z, fo[i].x, fo[i].y, fo[i].z);
    drawJoint(co[i].x, co[i].y, co[i].z, 10);
    
    // Femur
    line(fo[i].x, fo[i].y, fo[i].z, to[i].x, to[i].y, to[i].z);
    drawJoint(fo[i].x, fo[i].y, fo[i].z, 5);
    
    // Tibia
    line(to[i].x, to[i].y, to[i].z, eo[i].x, eo[i].y, eo[i].z);
    drawJoint(to[i].x, to[i].y, to[i].z, 5);

    // Effector
    drawJoint(eo[i].x, eo[i].y, eo[i].z, 5);
 }
}
