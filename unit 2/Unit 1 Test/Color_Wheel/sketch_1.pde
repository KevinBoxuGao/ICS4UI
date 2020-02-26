//GLOBAL VARIABLES
int n = 800;   //number of dots
int R = 300;  //radius of the main ring
int r = 10;   //radius of a dot

int xC = 300; //(x,y) coordinates of the centre of the ring
int yC = 300;

int[] radiusValues = new int[n];
float[] thetaValues = new float[n];


void draw() {
  for(int i=0; i<n; i++) {
    float xVal = xC + radiusValues[i]*cos(thetaValues[i]);
    float yVal = yC - radiusValues[i]*sin(thetaValues[i]);
    if(thetaValues[i] < PI/2) {
      fill(255, 0, 0);
    }
    else if (PI/2 <= thetaValues[i] && thetaValues[i] < PI) {
      fill(255, 255, 255);
    }
    else if ((PI <= thetaValues[i]) && (thetaValues[i] < 3*PI/2)) {
      fill(255, 0, 255);
    }
    else {
      fill(0, 255, 255);
    }
    circle(xVal, yVal, 5);
    
  }
}

void setup() {
  size(1200, 800);
  background(0);
  for(int i=0; i < n; i++) {
    int r = int(random(1, R));
    int theta = int(random(0, 359));
    float thetaRadians = radians(theta);
    radiusValues[i] = r;
    thetaValues[i] = thetaRadians;
  }
  println("Setup is complete. Drawing can now begin.");
  noLoop();
}
