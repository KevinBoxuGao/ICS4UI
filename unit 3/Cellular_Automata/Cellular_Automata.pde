import java.util.Iterator;
import java.util.HashSet;

//change these
String climate="arid"; //can be {"polar", "temperate", "arid", "tropical", "mediterranean"}
int gridWidth = 20;
int framesPerSecond = 10;
int numVillages = 10; //number of villages initially generated
int sustainabilityThreshHold = 400; //amount of total health around a village to keep it in place
int villageMovePenalty = 40; //penalty on land that village moves to
boolean smarterVillages = false; //boolean to indicate if smarter village movements want to be activated at cost of performance

//can still be changed but it is recommended to not be changed since it could affect realism
int humanLandImpact = 25; //amount of health humans deplete when using land
int desertLandImpact = 250; //amount of health deserts deplete when precipitation is 1

//don't change these
color[][] cellsNow;
int[][] healthNow;
int[][] healthNext;
int[][] villageCoords;
float cellSize;
float padding = 50;
boolean evolution = true; //bool for which phase of evolution is occuring

float currentTemp;
float tempIncreasePerYear = 0.02/12;
float currentTempIncrease = 0; //total temperature increase
int currentMonth = 0;
float precipitation;

//climate variables set by climate
int climateAmplitude;
float climateVS;
//precipitation variables set by climate
int precipitationAmplitude;
float precipitationVS;


//utility functions
float roundAny(float x, int d) {
  if (d==0) {
    return round(x);
  } 
  float roundedValue;
  roundedValue = x * pow(10, d);
  roundedValue = round(roundedValue);
  roundedValue = roundedValue / pow(10, d);
  return roundedValue;
}

//climate calculations
float getCurrentTemperature(int month) {
  return climateAmplitude*cos((PI/12)*(month)) + climateVS + currentTempIncrease;
}
float getCurrentPrecipitation(int month) {
  float p = precipitationAmplitude*cos((PI/12)*(month)) + precipitationVS - 75*currentTempIncrease;
  if(p<0) {
    return 0;
  } else {
    return p;
  }
}
//evolution actions
int[][] directions = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1,-1}, {1,0}, {1,1}}; //direction vectors
void depleteSurrounding(int row, int column, int amount) {
  for(int i=0; i<8; i++) {
    try {
      int n = row+(directions[i][0]);
      int m = column+(directions[i][1]);
      if (cellsNow[row][column] == color(220, 220, 220));
        if (cellsNow[n][m] != color(237,201,175) && cellsNow[n][m]!=color(220,220,220)){
          healthNow[n][m] -= amount;
        }         
      else {
        if(cellsNow[n][m] != color(237,201,175)) { //square isn't a desert
          healthNow[n][m] -= amount;
        } 
      }
    } catch(Exception e) {
      continue;
    }
  }
}
//evolution calculations
int[] neighbourAverage(int row, int column) {
  int neighbours = 0;
  int total = 0;
  for(int i=0; i<8; i++) {
    try {
      int n = row+(directions[i][0]);
      int m = column+(directions[i][1]);
      if(healthNow[n][m] <= 0) {
        total += 0; 
      } else {
        total += healthNow[n][m]; 
      }
      neighbours++;
    } catch(Exception e) {
      continue;
    }
  }
  int[] result = {total, neighbours};
  return result;
}
int villageDirection(int row, int column, int largestTotal) {
  int directionIndex = -1;
  int x = row;
  int y = column;
  for(int j=0; j<8; j++) {
    try {
      int newRow = row+(directions[j][0]);
      int newColumn = column+(directions[j][1]);
      //don't move to cell with a village already
      if(cellsNow[newRow][newColumn] != color(220,220,220)) {
        int[]newNeighbours = neighbourAverage(newRow, newColumn);
        int total = newNeighbours[0];
        if(total > largestTotal) {
          largestTotal = total;
          x = newRow;
          y = newColumn;
        }
      }
    } catch(Exception e) {
      continue;
    }
  }
  return directionIndex;
}

void setup(){
  currentTemp = getCurrentTemperature(0);
  precipitation = getCurrentPrecipitation(0);
  //set climate variables for land
  //climate can be {"polar", "temperate", "arid", "tropical", "mediterranean"}
  if(climate.equals("polar")) {
    climateAmplitude = -15;
    climateVS = -10;
    //4 low to 25 high
    precipitationAmplitude = -10;
    precipitationVS = 25;
  } else if(climate.equals("temperate")) {
    climateAmplitude = -17;
    climateVS = 5;
    //14 low to 84 high
    precipitationAmplitude = 30;
    precipitationVS = 44;
  } else if(climate.equals("arid")) {
    climateAmplitude = 8;
    climateVS = 20;
    //44 low to 7 high
    precipitationAmplitude = 18;
    precipitationVS = 25;
  } else if(climate.equals("tropical")) {
    climateAmplitude = 2;
    climateVS = 26;
    //216 low to 9 high
    precipitationAmplitude = 103;
    precipitationVS = 112;
  } else if(climate.equals("mediterranean")) {
    climateAmplitude = -8;
    climateVS = 16;
    //128 low to 14 high
    precipitationAmplitude = 57;
    precipitationVS = 71;
  } else {
    println("invalid climate");
    exit();
  }
  cellsNow = new color[gridWidth][gridWidth];
  healthNow = new int[gridWidth][gridWidth];
  healthNext = new int[gridWidth][gridWidth];
  villageCoords = new int[numVillages][2];
  cellSize = (height-2*padding-100)/gridWidth;
  size(1000,800);
  frameRate( framesPerSecond );  
  setInitialLand();
}

void draw() {
  background(0,0,255);
  //titles
  PFont Title = createFont("Arial Bold", 64);
  fill(255);
  textFont(Title);  
  textAlign(CENTER, CENTER);
  text("Desertification", 350, 65);
  
  PFont subTitle = createFont("Helvetica", 32);
  fill(220);
  textFont(subTitle);  
  textAlign(CENTER, TOP);
  text("Cellular Automata", 350, 95);
  
  //stats
  //sidebar for stats
  fill(80);
  noStroke();
  rect(700, 0, 1200, 800);
  //title
  PFont statsTitle = createFont("Arial Bold", 32);
  fill(255);
  textFont(statsTitle);  
  textAlign(LEFT, TOP);
  text("Statistics", 715, 95);
  textAlign(LEFT, TOP);
  //headings
  PFont statTitle = createFont("Helvetica", 32);
  fill(255);
  textFont(statTitle);  
  text("Years:", 720, 140);
  text("Months:", 720, 230);
  text("Temperature:", 720, 310);
  textLeading(30);
  text("Total Temperature\nIncrease:", 720, 400);
  //data values
  PFont stat = createFont("Helvetica", 24);
  textFont(stat);
  fill(220);
  text(str(currentMonth/12), 725, 180);
  text(str(currentMonth), 725, 270);
  text(str(roundAny(currentTemp, 1)), 725, 350);
  text(str(roundAny(currentTempIncrease, 1)), 725, 470);
  
  //grid
  stroke(0);
  float y = padding+100;
  for(int i=0; i<gridWidth; i++) {
    for(int j=0; j<gridWidth; j++) {
      float x = padding + j*cellSize;
      fill(cellsNow[i][j]);
      rect(x, y, cellSize, cellSize);
    }
    y += cellSize;
  }
  getNextGeneration();
}

void getNextGeneration() {
  //depletion 
  if(evolution) {
    //calculate climate stats and data
    currentMonth++;
    currentTempIncrease += tempIncreasePerYear;
    currentTemp = getCurrentTemperature(currentMonth);
    precipitation = getCurrentPrecipitation(currentMonth);
    //deplete land
    for(int i=0; i<gridWidth; i++) {
      for(int j=0; j<gridWidth; j++) {
        if(cellsNow[i][j] == color(220,220,220)) { //is village 
          depleteSurrounding(i, j, humanLandImpact);
        } else if(cellsNow[i][j] == color(237,201,175)) { //is desert 
          depleteSurrounding(i, j, int(desertLandImpact/precipitation));
        }
      }
    }
    evolution = false;
  } 
  
  //recovery
  else { 
    //move villages
    for(int i=0; i<numVillages; i++) {
      int row = villageCoords[i][0];
      int column = villageCoords[i][1];
      int[]neighbours = neighbourAverage(row, column);
      int largestTotal = neighbours[0];
      if(largestTotal < sustainabilityThreshHold) {
        int x = row;
        int y = column;
        for(int j=0; j<8; j++) {
          try {
            int newRow = row+(directions[j][0]);
            int newColumn = column+(directions[j][1]);
            //don't move to cell with a village already
            if(cellsNow[newRow][newColumn] != color(220,220,220)) {
              int[]newNeighbours = neighbourAverage(newRow, newColumn);
              int total = newNeighbours[0];
              if(total > largestTotal) {
                largestTotal = total;
                x = newRow;
                y = newColumn;
              }
            }
          } catch(Exception e) {
            continue;
          } 
        }
        if(x!=row || y!=column) {
          villageCoords[i][0] = x;
          villageCoords[i][1] = y;
          cellsNow[row][column] = color(200-(healthNow[row][column]*2), 255, 0);
          cellsNow[x][y] = color(220,220,220);
          int newHealth = (healthNow[x][y] - villageMovePenalty) / 2;
          healthNow[x][y] = (newHealth > 0) ? newHealth: 0;
          println(healthNow[x][y]);
          
        }
      }
    }
    //replenish land
    for(int i=0; i<gridWidth; i++) {
      for(int j=0; j<gridWidth; j++) {
        //is not desert
        if(cellsNow[i][j] == color(220,220,220)) {
          int[] neighbours = neighbourAverage(i, j);
          int healthTotal = healthNow[i][j] + int((precipitation/4)*((neighbours[0] / neighbours[1])+1)/2);
          healthNext[i][j] = (healthTotal > 100) ? 100 : healthTotal;
        } else {
          if(cellsNow[i][j] != color(237,201,175)) { 
            int[] neighbours = neighbourAverage(i, j);
            int healthTotal = healthNow[i][j] + int((precipitation/4)*((neighbours[0] / neighbours[1])+1));
            healthNext[i][j] = (healthTotal > 100) ? 100 : healthTotal;
          }
        }
      }
    }
    evolution = true;
    
    //change health now to health next
    for(int i=0; i<gridWidth; i++) {
      for(int j=0; j<gridWidth; j++) {
        healthNow[i][j] = healthNext[i][j];
      }
    }
  }
 
  
  //update colors
  for(int i=0; i<gridWidth; i++) {
    for(int j=0; j<gridWidth; j++) {
      if((cellsNow[i][j] != color(220,220,220)) && (cellsNow[i][j] != color(237,201,175))) { 
        if(healthNow[i][j] <= 0) {
          cellsNow[i][j] = color(237,201,175);
        } else {
          cellsNow[i][j] = color(200-(healthNow[i][j]*2), 255, 0);  
        } 
      }
    }
  }
}


//set up board
void setInitialLand() {
  //fill health and land based on health
  for(int i=0; i<gridWidth; i++) {
    for(int j=0; j<gridWidth; j++) {
      healthNow[i][j] = 100;
      cellsNow[i][j] = color(0,255,0);
    }
  }
  //insert villages
  int cellsNum = gridWidth*gridWidth; //represent each tile as integer
  if(numVillages >= cellsNum) { //there are villages equal or more than possible tiles
    for(int i=0; i<gridWidth; i++) {
      for(int j=0; j<gridWidth; j++) {
        healthNow[i][j] = (healthNow[i][j] / 4) - villageMovePenalty;
        cellsNow[i][j] = color(220,220,220);
      }
    }
  } else {
    //use a set because it is efficient in lookup
    HashSet<Integer> villages = new HashSet<Integer>(); //hold village numbers
    for(int i=0; i<numVillages; i++) {
      //loop continuously to get unique number for village
      int index = int(random(1, cellsNum));
      while(villages.contains(index)) {
        index = int(random(1, cellsNum));
      }
      villages.add(index);
    }
    Iterator<Integer> i = villages.iterator(); //iterate through set
    int villageIndex = 0;
    while (i.hasNext()) {
        int currentValue = i.next();
        int row = (currentValue / gridWidth);
        int column = (currentValue % gridWidth);
        cellsNow[row][column] = color(220,220,220);
        villageCoords[villageIndex][0] = row;
        villageCoords[villageIndex][1] = column;
        villageIndex++;
    }
  }
}
