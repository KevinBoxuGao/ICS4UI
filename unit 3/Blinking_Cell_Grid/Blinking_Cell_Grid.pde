boolean[][] cells;
//THIS VERSION ANIMATES

int rows = 10;
int columns = 10;
float cellSize;
float padding = 50;
int blinksPerSecond = 2; //used in the call to frameRate() inside setup()

void setup(){
  size(1000,1000);
  cellSize = (width-2*padding)/rows;
  cells = new boolean[rows][columns];
  setCellValuesRandomly();
  frameRate( blinksPerSecond );
  //NOTICE WE'VE LEFT OUT THE noLoop() COMMAND, SO draw() will be called repeatedly in an animation
}

void draw() {  
  background(255,255,0);
  for(int i=0; i<rows; i++) {
    float x = padding + i*cellSize;
    for(int j=0; j<columns; j++) {
      float y = padding + j*cellSize;
      if (cells[i][j])
        fill(255);
        
      else
        fill(0);
        
      rect(x, y, cellSize, cellSize);
    }
  }
  
  setCellValuesRandomly(); //RESETS THE CELL VALUES AFTER EACH FRAME, CREATING A BLINKING EFFECT.
}

void setCellValuesRandomly() {
  for(int i=0; i<rows; i++) {
    for(int j=0; j<columns; j++) {
      int x = round(random(0,1));
      if (x == 0)
        cells[i][j] = false;
      else
        cells[i][j] = true;
    }
  }
}

 
