import java.util.Map;
int n = 12;   
int R = 300;  
float r = 10;   

int xC = 600; 
int yC = 400;

float[] xValues = new float[n];
float[] yValues = new float[n];

color yellow = #ffff00;
color red = #ff0000;
color white = #ffffff;
color purple = #6a0dad;
color cyan = #00FFFF;

void draw() {
  for(int i=0; i < n; i++) {
    println("Drawing lines from dot number", i);
      for(int j=0; j < n; j++) {
        stroke(yellow);
        line( xValues[i], yValues[i], xValues[j], yValues[j]);
      }
  }
  color circleColor;
    
  for(int i=0; i < n; i++) {
    if (i < n/4) {
        circleColor = red;
    } else if(n/4 <= i && i < n/2) {
        circleColor = white;
    } else if(n/2 <= i && i < 3*n/4) {
        circleColor = purple;
    } else {
        circleColor = cyan;
    }
    fill(circleColor);
    circle( xValues[i], yValues[i], 2*r);
  }   
}

void setup() {
  size(1200, 800);
  background(0);
  
  float deltaTheta = 2*PI/n;
  float angle = 0;
  
  for(int i=0; i < n; i++) {
    float currX = xC + R*cos( angle ); 
    float curry = yC - R*sin( angle );

    xValues[i] = currX;
    yValues[i] = curry;

    angle = angle + deltaTheta;
  }
  println("Setup is complete. Drawing can now begin.");
  noLoop();
}
