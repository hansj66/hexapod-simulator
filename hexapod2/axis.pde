void drawAxis()
{
  pushMatrix();
  
  stroke(80,80,80);
  // X-axis
  line(0,0,0, 300,0,0);
  line(315,5,0,325,-5,0);
  line(315,-5,0,325,5,0);
  beginShape();
  vertex(300,0,0);
  vertex(300,10,0);
  vertex(310,0,0);
  vertex(300,-10,0);
  endShape(CLOSE);
  
  // Y-axis
  
  line(0,0,0, 0,300,0);
  line(5,315,0,-5,325,0);
  line(-5,315,0,0,320,0);
  beginShape();
  vertex(0,300,0);
  vertex(5,300,0);
  vertex(0,305,0);
  vertex(-5,300,0);
  endShape(CLOSE);
  
  
  popMatrix();
}
