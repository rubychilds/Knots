import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 
import controlP5.*; 
import processing.dxf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class torus_knot extends PApplet {





PMatrix3D currCameraMatrix;
PGraphics3D g3;
ControlP5 MyController;

PeasyCam cam;
PVector[][] globe;

boolean saveDXF = false;

int total = 250;
float p = 2.0f;
float q = 3.0f;

public void setup(){
    
    cam = new PeasyCam(this, 500);
    globe = new PVector[251][1];
    colorMode(HSB);
    g3 = (PGraphics3D)g;
    MyController = new ControlP5(this);
    setupControllers();
    MyController.setAutoDraw(false);  
}

public void gui() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  MyController.draw();
  g3.camera = currCameraMatrix;
}

public void draw(){
  background(0);

   lights();
   float radius = 50;
   
   if(saveDXF == true){
    beginRaw(DXF, "data/myCubes.dxf");
   }
   
   stroke(255);
   for(int i = 0; i <= total; i++){
     
      float phi = map(i, 0, total, 0, TWO_PI);
      
      float x = sin(phi)+2*sin(2*phi);
      float y = cos(phi)-2*cos(p*phi);
      float z = -sin(q*phi);
      
      globe[i][0] = new PVector(x,y,z);
   }
   
   strokeWeight(5);
   strokeCap(ROUND);
   for(int i = 0; i <= total; i++){
     
     float hu = map(i, 0, 250, 0, 255);
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

public void keyPressed(){
  if(key == 's'){
    saveDXF = true;
  }
}

public void setupControllers(){
  
    MyController.addNumberbox("p").setPosition(50,10)
     .setSize(30,30)
     .setScrollSensitivity(1.1f)
     .setValue(2);
     
    MyController.addNumberbox("q").setPosition(100,10)
     .setSize(30,30)
     .setScrollSensitivity(1.1f)
     .setValue(3);
}
  public void settings() {  size(1000,1000, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "torus_knot" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
