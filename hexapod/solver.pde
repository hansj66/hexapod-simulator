void solve(int leg)
{
  CoxaUpdate u = find_target_coxa_angle(leg);

  if (u.Modified())
  {
    println("Modified. Old angle is", coxa_angles[leg], "New angle is: ", degrees(u.NewAngle()));
    coxa_angles[leg] = degrees(u.NewAngle());
  }
  
  // Check if effector target is within reach. 
  
  // TODO
  // 1) Check angle constrains. If violated, then indicate this visually
  // 2) Check distance between femur origin and targer and compare with total length
  //    of temur and tibia (also check femur/tibia angle constraints)
  // 3) Simple heuristic solver for approximating final femur and tibia angles
  // 4) Servo angle offsets
}


CoxaUpdate find_target_coxa_angle(int leg)
{
  float t_x = effector_targets[leg].x;
  float c_x = coxa_origins[leg].x;
  float t_y = effector_targets[leg].y;
  float c_y = coxa_origins[leg].y;
  
  float deltaPI = 0;
  float dx = abs (t_x - c_x);
  float dy = abs (t_y - c_y);
  
  if ((dy == 0) && (dx == 0))
    return new CoxaUpdate(false, coxa_angles[leg]);

  if ((t_x >= c_x) && (t_y >= c_y))
  {
  }
  else if ((t_x <= c_x) && (t_y >= c_y))
  {
    deltaPI = PI;
  }
  else if ((t_x <= c_x) && (t_y <= c_y))
  {
    deltaPI = 1.5*PI;
  }
  else if ((t_x >= c_x) && (t_y <= c_y))
  {
    deltaPI = 2*PI;
  }

  return new CoxaUpdate(true, deltaPI + asin(dy/sqrt(dy*dy+dx*dx)));
}
