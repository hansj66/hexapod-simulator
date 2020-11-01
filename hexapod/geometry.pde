
int legs = 6;
int base_height = 120;

float coxa_length = 45;      
float femur_length = 61.5;   
float tibia_length = 132;  

PVector[] coxa_origins = new PVector[legs];
PVector[] femur_origins = new PVector[legs];
PVector[] tibia_origins = new PVector[legs];
PVector[] effector_origins = new PVector[legs];

PVector[] effector_targets = new PVector[legs];
// PVector[] effector_targets_model = new PVector[legs];


// coxa angle == X/Y angle for the entire leg, since the femur
// and tibia can only rotate in X/Z.
float[] coxa_angles = new float[] {70,0,290,250,180,110};        

// Coxa constraint (Z rotation only)
// TBD min/max values
float[] coxa_angles_min = new float[] {0,0,0,0,0,0};
float[] coxa_angles_max = new float[] {0,0,0,0,0,0};

// Femur constraint (rotation on axis orthogonal to Z/femur-tibia plane)
// TBD min/max values
float[] femur_angles_min = new float[] {0,0,0,0,0,0};
float[] femur_angles_max = new float[] {0,0,0,0,0,0};

// Tibia constraint (rotation on axis orthogonal to Z/femur-tibia plane)
// TBD min/max values
float[] tibia_angles_min = new float[] {0,0,0,0,0,0};
float[] tibia_angles_max = new float[] {0,0,0,0,0,0};


float[] femur_angles = new float[] {-45,-45,-45,-45,-45,-45};
float[] tibia_angles = new float[] {120,120,120,120,120,120,120};

float[] servo_coxa_offset_angles = new float[] {0,0,0,0,0,0};  // XY
float[] servo_femur_offset_angles = new float[] {0,0,0,0,0,0}; // XZ
float[] servo_tibia_offset_angles = new float[] {0,0,0,0,0,0}; // XZ


void initialize_base_geometry()
{
  coxa_origins[0] = new PVector(49,47,0);
  coxa_origins[1] = new PVector(65.5,0,0);
  coxa_origins[2] = new PVector(49,-47,0);
  coxa_origins[3] = new PVector(-49,-47,0);
  coxa_origins[4] = new PVector(-65.5,0,0);
  coxa_origins[5] = new PVector(-49,47,0);
    
  coxa_angles[0] = 70;
  coxa_angles[1] = 0;
  coxa_angles[2] = 290;
  coxa_angles[3] = 250;
  coxa_angles[4] = 180;
  coxa_angles[5] = 110;

  femur_angles[0] = -45; 
  femur_angles[1] = -45;
  femur_angles[2] = -45;
  femur_angles[3] = -45;
  femur_angles[4] = -45;
  femur_angles[5] = -45;

  tibia_angles[0] = 120; 
  tibia_angles[1] = 120; 
  tibia_angles[2] =  120;
  tibia_angles[3] =  120;
  tibia_angles[4] =  120;
  tibia_angles[5] =  120;
}

void drawEffectorTargets()
{
  for (int i=0; i<legs; i++)
  {
    pushMatrix();
    translate(effector_targets[i].x, effector_targets[i].y, effector_targets[i].z);    
    //effector_targets_model[i] = new PVector(modelX(0,0,0), modelY(0,0,0), modelZ(0,0,0));

    if (i != 0)
      stroke(0,0,255);
    else
      stroke(0,255,0);
    
    sphere(10);
    popMatrix();
  }
}

void leg_up(int leg_index)
{
  femur_angles[leg_index] = -90;
  tibia_angles[leg_index] = 90; // XZ
  
}


float refresh_leg_geometry()
{
    for (int i=0; i<legs; i++)
    {
      stroke(255);
      // Coxa
      pushMatrix();

      translate(coxa_origins[i].x, coxa_origins[i].y, coxa_origins[i].z);
      
      sphere(15);
      rotateZ(radians(coxa_angles[i]));
      line(0,0,0, coxa_length, 0,0);
      translate(coxa_length,0,0);
      femur_origins[i] = new PVector(modelX(0,0,0), modelY(0,0,0), modelZ(0,0,0));
      sphere(5);
      
      // Femur
      rotateY(radians(femur_angles[i]));
      line(0,0,0, femur_length, 0,0);
      translate(femur_length,0,0);
      tibia_origins[i] = new PVector(modelX(0,0,0), modelY(0,0,0), modelZ(0,0,0)); 
      sphere(5);
      
      // Tibia
      rotateY(radians(tibia_angles[i]));
      line(0,0,0, tibia_length, 0,0);
      translate(tibia_length,0,0);
      effector_origins[i] = new PVector(modelX(0,0,0), modelY(0,0,0), modelZ(0,0,0));
      
      // Effector
      stroke(255,0,0);
      sphere(5);
      
      popMatrix();
    }
    
    // This is a bit lazy, but it's a convenient way 
    // to get the floor z after initialization.
    return effector_origins[0].z; 
}

float initialize_geometry()
{
   println("initialize_geometry()"); 
  initialize_base_geometry();
  float retval = refresh_leg_geometry();
  for (int i=0; i<legs; i++)
  {
    effector_targets[i] = effector_origins[i].copy();
  }
  return retval;
}

void draw_base()
{
  stroke(255);
  for (int i=0; i<legs-1; i++)
  {
    line(
      coxa_origins[i].x,
      coxa_origins[i].y,
      coxa_origins[i].z,
      coxa_origins[i+1].x,
      coxa_origins[i+1].y,
      coxa_origins[i+1].z
    );
  }
  line(
    coxa_origins[legs-1].x,
    coxa_origins[legs-1].y,
    coxa_origins[legs-1].z,
    coxa_origins[0].x,
    coxa_origins[0].y,
    coxa_origins[0].z
  );
}


void draw_robot()
{
  refresh_leg_geometry();
  draw_base();
  drawEffectorTargets();
}
