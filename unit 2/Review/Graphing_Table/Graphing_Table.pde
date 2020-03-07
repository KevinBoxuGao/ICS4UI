float[][] myData = new float[3200][2];
boolean animate = true;
float a = 0;

void draw() {;
  for(int i=0; i < myData.length; i++ ) {
     float x = i*0.5;
     float y = 0.001*pow(x, 2)*sin(a*x) + 300; 
     myData[i][0] = x;
     myData[i][1] = y;
     ellipse( myData[i][0], myData[i][1], 3, 3);
  }
  background(0);
  fill(255,0,0);
  noStroke();
  for(int i=0; i < myData.length; i++ ) {
     ellipse( myData[i][0], myData[i][1], 3, 3);
  }
  a += 0.0005;
}

void setup() {
  size(600, 600);
    if( animate ) {
    a = 0;
  }
  
  else {
    a = 0.2;
    noLoop(); //MAKES draw() GET CALLED ONLY ONCE, INSTEAD OF REPEATEDLY
  }

}
