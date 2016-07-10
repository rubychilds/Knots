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
int total = 1000;

void setup(){
    size(1000,1000, P3D);
    cam = new PeasyCam(this, 100);
    globe = new PVector[total+1][1];
    colorMode(HSB);
    g3 = (PGraphics3D)g;
    MyController = new ControlP5(this);
    MyController.setAutoDraw(false);  
}

void gui() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  MyController.draw();
  g3.camera = currCameraMatrix;
}

void draw(){
  background(0);

   lights();
   float radius = 50;
   
   if(saveDXF == true){
    beginRaw(DXF, "data/" + Float.toString(frameRate) + ".dxf");
   }
   
   stroke(255);
   for(int i = 0; i <= total; i++){
     
      float beta = map(i, 0, total*2, 0, TWO_PI);
      
      float r = 0.8+1.6*sin(6*beta);
      float theta = 2*beta;
      float phi = 0.6*PI*sin(12*beta);
      
      float x = r*cos(phi)*cos(theta);
      float y = r*cos(phi)*sin(theta);
      float z = r*sin(phi);
      
      globe[i][0] = new PVector(x,y,z);
   }
   
   strokeWeight(5);
   strokeCap(ROUND);
   for(int i = 0; i <= total; i++){

      float hu = map(i, 0, total, 0, 255);
      stroke(hu%255, 255, 255);

      PVector v = globe[i][0];
      PVector v_next;
      
      if (i == total){
        v_next = globe[0][0];
      }
      else {
        v_next = globe[i+1][0];
      }

      line(radius*v.x,radius*v.y,radius*v.z, 
           radius*v_next.x, radius*v_next.y, radius*v_next.z);
  }

  if(saveDXF == true){
    endRaw();
    saveDXF = false;
  } 
  gui();
}

void keyPressed(){
  if(key == 's'){
    saveDXF = true;
  }
}