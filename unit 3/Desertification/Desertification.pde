/*By Kevin Boxu Gao 2020*/

import java.util.Iterator;
import java.util.HashSet;

/*change these*/
//affects the percipitation and temperature ranges
String climate="arid"; //can be {"polar", "temperate", "arid", "tropical", "mediterranean"}
int gridWidth = 20;
int framesPerSecond = 10;
int numVillages = 20; //number of villages initially generated
int sustainabilityThreshHold = 400; //minimum total health of neighbours to keep village in place
int villageMovePenalty = 40; //penalty on land that village moves to

//can still be changed but it is recommended to not be changed since it could affect realism
int humanLandImpact = 25; //amount of health humans deplete when using land
int desertLandImpact = 250; //amount divided by precipition to give the amount of health deserts deplete

//don't change these
color[][] cellsNow;
int[][] healthNow;
int[][] healthNext;
int[][] villageCoords;
float cellSize;
float padding = 50;
boolean evolution = true; //bool for which phase of evolution is occuring

float currentTemp;
float tempIncreasePerYear = 0.2/60;
float currentTempIncrease = 0; //total temperature increase
int currentMonth = 0;
float precipitation;
String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "Decemeber"};
String monthName = "January";

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
  float p = (precipitationAmplitude*cos((PI/12)*(month)) + precipitationVS) - pow(3*currentTempIncrease, 2);
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
      //is a village
      if (cellsNow[row][column] == color(220, 220, 220));
        //surrounding cell is not village or desert
        if (cellsNow[n][m] != color(237,201,175) && cellsNow[n][m]!=color(220,220,220)){
          int newHealth = healthNow[n][m] - amount;
          //prevent health lower than 0
          healthNow[n][m] = (newHealth > 0) ? newHealth: 0;
        }      
      //is a desert
      else { 
        //surrounding cell is not desert
        if(cellsNow[n][m] != color(237,201,175)) { //square isn't a desert
          int newHealth = healthNow[n][m] - amount;
          //prevent health lower than 0
          healthNow[n][m] = (newHealth > 0) ? newHealth: 0;
        } 
      }
    } catch(Exception e) {
      continue;
    }
  }
}
//evolution calculations
int[] neighbourInfo(int row, int column) {
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
  for(int i=0; i<8; i++) {
    try {
      int newRow = row+(directions[i][0]);
      int newColumn = column+(directions[i][1]);
      //don't move to cell with a village already
      if(cellsNow[newRow][newColumn] != color(220,220,220)) {
        int[]neighbours = neighbourInfo(newRow, newColumn);
        int total = neighbours[0];
        if(total > largestTotal) {
          largestTotal = total;
          directionIndex = i;
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
  
  /*stats*/
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
  text("Month Name:", 720, 320);
  text("Temperature(" + "\u00B0" + "C):", 720, 410);
  textLeading(30);
  text("Total Temperature\nIncrease:", 720, 500);
  text("Precipitation(mm)", 720, 610);
  //data values
  PFont stat = createFont("Helvetica", 24);
  textFont(stat);
  fill(220);
  text(str(currentMonth/12), 725, 180);
  text(str(currentMonth), 725, 270);
  text(monthName, 725, 360);
  text(str(roundAny(currentTemp, 1)), 725, 450);
  text(str(roundAny(currentTempIncrease, 2)), 725, 570);
  text(str(roundAny(precipitation, 1)), 725, 650);
  
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
    monthName = monthNames[(currentMonth % 12)];
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
    for(int i=0; i<numVillages; i++) { //loop through village coordinates
      int row = villageCoords[i][0];
      int column = villageCoords[i][1];
      int[]neighbours = neighbourInfo(row, column);
      int largestTotal = neighbours[0];
      int direction = villageDirection(row, column, largestTotal);
      
      if(direction != -1) { //village has a direction that it will move
        int[] directionVector = directions[direction];
        int newRow = row+directionVector[0];
        int newColumn = column+directionVector[1];
        
        //update village coordinates
        villageCoords[i][0] = newRow;
        villageCoords[i][1] = newColumn;
        
        //update cells
        if(healthNow[row][column] <= 0) { //update deserts under villages
          cellsNow[row][column] = color(237,201,175);
        } else {
          cellsNow[row][column] = color(255*(100-healthNow[row][column])/100, 255, 0);
        }
        cellsNow[newRow][newColumn] = color(220,220,220);
        
        //update health
        int newHealth = (healthNow[newRow][newColumn] - villageMovePenalty) / 2;
        healthNow[newRow][newColumn] = (newHealth > 0) ? newHealth : 0; //prevent health from being negative
      }
    }
    //replenish land
    for(int i=0; i<gridWidth; i++) {
      for(int j=0; j<gridWidth; j++) {
        if(cellsNow[i][j] != color(237,201,175)) { //isn't a desert
          //neighbour health information
          int[] neighbours = neighbourInfo(i, j);
          int surroundingHealthTotal = neighbours[0];
          int numNeighbours = neighbours[1];
          int averageSurroundingHealth = surroundingHealthTotal / numNeighbours;
          
          if(cellsNow[i][j] == color(220,220,220)) { //is a village
            if(healthNow[i][j] > 0) { //only replenish if underlying land is not desert
              //update health
              int healthTotal = healthNow[i][j] + int((precipitation/4)*(averageSurroundingHealth+1)/2);
              healthNext[i][j] = (healthTotal > 100) ? 100 : healthTotal; //prevent health being higher than 100
            }
          } else {
            int healthTotal = healthNow[i][j] + int((precipitation/4)*((neighbours[0] / neighbours[1])+1));
            healthNext[i][j] = (healthTotal > 100) ? 100 : healthTotal;
          }
          
          //update health now to health next
          for(int k=0; k<gridWidth; k++) {
            for(int l=0; l<gridWidth; l++) {
              healthNow[k][l] = healthNext[k][l];
            }
          }
        }
      }
    }
    evolution = true;
  }
 
  //update colors of cells after health changes
  for(int i=0; i<gridWidth; i++) {
    for(int j=0; j<gridWidth; j++) {
      if((cellsNow[i][j] != color(220,220,220)) && (cellsNow[i][j] != color(237,201,175))) { 
        if(healthNow[i][j] <= 0) {
          healthNow[i][j] = 0; //make sure health is always at least 0 for recovery calculations
          cellsNow[i][j] = color(237,201,175);
        } else {
          cellsNow[i][j] = color(255*(100-healthNow[i][j])/100, 255, 0);  
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
