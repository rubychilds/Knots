import peasy.*;
import controlP5.*;
import processing.dxf.*;

// http://paulbourke.net/geometry/knots/

PMatrix3D currCameraMatrix;
PGraphics3D g3;
ControlP5 MyController;

PeasyCam cam;
PVector[][] globe;

boolean saveDXF = false;

void setup(){
    size(1000,1000, P3D);
    cam = new PeasyCam(this, 500);
    globe = new PVector[251][1];
    g3 = (PGraphics3D)g;
    MyController = new ControlP5(this);

    MyController.setAutoDraw(false);  
}

void draw(){
  background(0);
  stroke(255);
  //ellipse(0,0,100,100);
  float max_len = 100;
  
  fill(255);
  
  for(float z = 0; z <= max_len; z+=1.0){
    if(z == 0.0 || z == max_len){
          fill(255);
     }
     else{
       noFill();
       stroke(255);
    }
    beginShape();
    for(float phi = 0; phi <= TWO_PI; phi+= PI/360){
      float x = 100*cos(phi);
      float y = 100*sin(phi);
      vertex(x,y, z);
    }
    endShape();
  }
  
  

  if(saveDXF == true){
    endRaw();
    saveDXF = false;
  } 
}