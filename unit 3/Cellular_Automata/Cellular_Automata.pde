//change these
int gridWidth = 200;
int framesPerSecond = 60;
int villages = 5;

//don't change these
boolean[][] cellsNow;
boolean[][] cellsNext;
int[][] cellHealth;
float cellSize;
float padding = 50;

float currentTemp;


void setup(){
  cellsNow = new boolean[gridWidth][gridWidth];
  cellsNext = new boolean[gridWidth][gridWidth];
  cellsHealth = new boolean[gridWidth][gridWidth];
  cellSize = (width-2*padding)/gridWidth;
  size(1000,1000);
  frameRate( framesPerSecond );
  //setInitialLand();
}

void draw() {
  background(0,0,255);
    
  float y = padding;
  
  for(int i=0; i<gridWidth; i++) {
    for(int j=0; j<gridWidth; j++) {
      float x = padding + j*cellSize;
      if (cellsNow[i][j])
        fill(255);
      else
        fill(0);
      rect(x, y, cellSize, cellSize);
    }
    y += cellSize;
  }
}

/*
int directions[][] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1,-1}, {1,0}, {1,1}};

int findNeighbours(int row, int column) {
  int neighbours = 0;
  for(int i=0; i<8; i++) {
    try {
      if(cellsNow[row+(directions[i][0])][column+(directions[i][1])]) {
        neighbours++;
      }     
    } catch(Exception e) {
      continue;
    }
  }
  return neighbours;
}

void getNextGenerationUsingGOLRules() {
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      int neighbours = findNeighbours(i, j);
      if(cellsNow[i][j]) {
        if(neighbours < 2) {
          cellsNext[i][j] = false;
        } else if(neighbours <= 3) {
          cellsNext[i][j] = true;
        } else if(neighbours > 3) {
          cellsNext[i][j] = false;
        } 
      } else {
        if(neighbours == 3) {
          cellsNext[i][j] = true;
        }
      }
    }
  }
  //set cellsNow to cellsNext
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      cellsNow[i][j] = cellsNext[i][j];
    }
  }
}


//set up boards
void setInitialLand(int m) {

}
*/
