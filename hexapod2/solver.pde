
PVector[] co_s = new PVector[legs]; // Coxa origins
PVector[] fo_s = new PVector[legs]; // Femur origins
PVector[] to_s = new PVector[legs]; // Tibia origins
PVector[] eo_s = new PVector[legs]; // Effector origins

void initializeSolver()
{
  for (int i=0; i<legs; i++)
  {
    co_s[i] = co[i].copy();
    fo_s[i] = fo[i].copy();
    to_s[i] = to[i].copy();
    eo_s[i] = eo[i].copy();
  }
}  

void initializeTargetPositions(float deltaX, float deltaY, float deltaZ)
{
  for (int i=0; i<legs; i++)
  {
    target[i].x = eo[i].x + deltaX;
    target[i].y = eo[i].y + deltaY;
    target[i].z = eo[i].z + deltaZ;
  }
}


void drawTargets()
{
  for (int i=0; i<legs; i++)
  {
    pushMatrix();
    translate(target[i].x, target[i].y, target[i].z);
    stroke(255,0,0);
    sphere(0.5);
    popMatrix();
  }
}

boolean isTargetReachable(int i)
{
    if (sqrt( (fo[i].x-target[i].x)*(fo[i].x-target[i].x) +
                (fo[i].y-target[i].y)*(fo[i].y-target[i].y) + 
                (fo[i].z-target[i].z)*(fo[i].z-target[i].z) ) > fl+tl)
                {
                  return false;
                }
  return true;
}

PVector calculatePoint(PVector a, PVector b, float segmentLength)
{
  // https://math.stackexchange.com/questions/83404/finding-a-point-along-a-line-in-three-dimensions-given-two-points
  PVector a_copy = a.copy();
  PVector b_copy = b.copy();

  PVector c = b_copy.sub(a_copy);
  c = c.div(c.mag());
  
  PVector d = c.mult(segmentLength);
  PVector e = a_copy.add(d);
  return e;
}

void drawJoint(PVector p, float jointSize)
{
  pushMatrix();
  translate(p.x, p.y, p.z);
  sphere(jointSize);
  popMatrix();
}

void drawSegment(PVector a, PVector b)
{
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}

boolean logged = false;

float calculateNewCoxaAngle(int leg)
{
  float y_distance = abs(target[leg].y - co[leg].y);
  float xy_distance = sqrt((target[leg].x - co[leg].x) * (target[leg].x - co[leg].x) + (target[leg].y - co[leg].y) * (target[leg].y - co[leg].y));   
  float angle  = asin(y_distance / xy_distance);
  float delta = 0;
  if ((target[leg].x < co[leg].x) && (target[leg].y >= co[leg].y))
  {
    delta = PI/2;
  }
  else if ((target[leg].x < co[leg].x) && (target[leg].y < co[leg].y))
  {
    delta = PI;
  }
  else if ((target[leg].x >= co[leg].x) && (target[leg].y < co[leg].y))
  {
    delta = 3*PI/2;
  }
  
  angle +=delta;
  
  // And now for the ugly hard coded part. This is to ensure that the coxa segment
  // always points out from the main body
  // Enumeration scheme (with X arrow pointing to the right and y axis pointing upwards):
  // Leg 0: NE
  // Leg 1: E
  // Leg 2: SE
  // Leg 3: SW
  // Leg 4: W
  // Leg 5: NW
  
  // TODO Constraints
  switch (leg)
  {
    case 0: break; 
    case 1: break;
    case 2: break;
    case 3: break;
    case 4: break;
    case 5: break;
  }
  
 
  return degrees(angle);
}


void solve()
{
  initializeSolver();

  // Check distance between femur origin and target position. 
  // If this distance is greater then the total length of the leg segments, then the target is unreachable
  int leg = 0;
  
  if (!isTargetReachable(leg))
  {
    println("Target is unreachable");
    return;
  }
  

  float angle = calculateNewCoxaAngle(leg);
  
  if (!logged) 
  {
    print("Angle: ");
    println(angle);
    // TODO: Check against coxa angle constraints
    logged = true;
  }
  
  for (leg=0; leg < legs; leg+=2)
  {
    PVector f0, f1, f2, f3;
    PVector r0, r1, r2, r3;
  
    r2 = to_s[leg].copy();
    r1 = fo_s[leg].copy();
    r0 = co_s[leg].copy();
  
    for (int i=0; i<10; i++)
    {
      stroke(255,0,0);
      // Forward pass
      f0 = target[leg].copy();
      f1 = calculatePoint(f0, r2, tl);
      drawJoint(f1, 2);
      drawSegment(f0, f1);
    
      f2 = calculatePoint(f1, r1, fl); 
      drawJoint(f2, 2);
      drawSegment(f1, f2);
    
      f3 = calculatePoint(f2, r0, cl); 
      drawJoint(f3, 2);
      drawSegment(f2, f3);
    
      // Reverse pass
      stroke(255,255,0);
      r0 = co_s[leg].copy();
      r1 = calculatePoint(r0, f2, cl);
      drawJoint(r1, 2);
      drawSegment(r0, r1);
      
      r2 = calculatePoint(r1, f1, fl); 
      drawJoint(r2, 2);
      drawSegment(r1, r2);
    
      r3 = calculatePoint(r2, f0, tl); 
      drawJoint(r2, 2);
      drawSegment(r2, r3);
    }
  }
  

/*
  pushMatrix();
  // 1. Set end effector equal to target
  eo_s[leg] = target[leg].copy();
  // stroke(128,128,128);
//  line(eo_s[leg].x, eo_s[leg].y, eo_s[leg].z, to_s[leg].x, to_s[leg].y, to_s[leg].z);
  stroke(0,0,128);
  translate(eo_s[leg].x, eo_s[leg].y, eo_s[leg].z);
  sphere(2);
  popMatrix();
*/  
  // Find new point (tibia length from target) along the line
  
  

  
  
}
