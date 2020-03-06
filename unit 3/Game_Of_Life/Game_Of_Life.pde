int n = 200;
boolean[][] cellsNow;
boolean[][] cellsNext;

float cellSize;
float padding = 50;
int blinksPerSecond = 60;

void setup(){
  cellsNow = new boolean[n][n];
  cellsNext = new boolean[n][n];
  size(1000,1000);
  cellSize = (width-2*padding)/n;
  frameRate( blinksPerSecond );
  //setCellValuesRandomly();
  //setSquare();
  setCheckerBoard(100);
}

void draw() {
  background(0,0,255);
    
  float y = padding;
  
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      float x = padding + j*cellSize;
      
      if (cellsNow[i][j])
        fill(255);
        
      else
        fill(0);
        
      rect(x, y, cellSize, cellSize);
    }
    y += cellSize;
  }
  
  //setCellValuesRandomly();
  getNextGenerationUsingGOLRules();
  //and then overwrite cellsNow with cellsNext
}

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
void setCheckerBoard(int m) {
  int startX = (n / 2) - (m / 2);
  int endX = (n / 2) + (m / 2);
  for(int i=startX; i<endX; i++) {
    for(int j=startX; j<endX; j++) {      
      if((i+j) % 2 == 0) {
        cellsNow[i][j] = true;
      } else {
        cellsNow[i][j] = false;
      }
    }
  }
}

void setCellValuesRandomly() {
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {      
      int x = round(random(0,1));
      if (x == 0)
        cellsNow[i][j] = false;
      else
        cellsNow[i][j] = true;
    }
  }
}
