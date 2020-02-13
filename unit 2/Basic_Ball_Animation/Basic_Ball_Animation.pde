//GLOBAL VARIABLES
float xBall, yBall;

//MAIN PROGRAM
void setup(){
  size(1600,800);
  xBall = 0;
  yBall = height/4;   //Here, height is automatically 
                      //set to 600/2 and width to 800/2
}

//DRAW() GETS CALLED ~30 TIMES PER SECOND AFTER SETUP() FINISHES 
void draw(){
  float r = xBall/width * 255;
  float b = yBall/width * 255;
  background(r,0,b);
  
  circle(xBall, yBall, 50);
  
  xBall = xBall + (mouseX-xBall)*0.03;
  yBall = yBall + (mouseY-yBall)*0.03;
}



//OTHER THINGS TO TRY
  //xBall = xBall + (width-xBall)*0.02;
  //xBall += (mouseX-xBall)*0.2;
  //yBall += (mouseY-yBall)*0.2;
