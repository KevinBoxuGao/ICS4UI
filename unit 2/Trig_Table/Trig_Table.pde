int euclid(int max, int min) {
  int remainder = max % min;
  if (remainder == 0) {
     return min; 
  } else {
    return euclid(min, remainder);
  }
}

String reduceFraction(int numerator, int denominator) {
  int gcf = euclid(numerator, denominator);
  int rn = numerator / gcf;
  int rd = denominator / gcf;
  String nString = (rn != 0)  ? ((rn == 1) ? "\u03C0" : str(rn)) + "\u03C0" : "0" ;
  String dString = (rn != 0)  ? ((rd == 1) ? "" : "/" + str(rd)) : "";
  String result = nString + dString;
  return result;
}


float roundAny(float number, int digits) {
  number = number * pow(10, digits);
  number = round(number);
  number = number / pow(10, digits);
  return number;
}  

int[] getFraction(String number){
  int slashIndex = number.indexOf("/");
  int pIndex = number.indexOf("p");
  int n = (pIndex == 0) ? 1 : int(number.substring(0, pIndex));
  int d = (slashIndex == -1) ? 1 : int(number.substring(slashIndex + 1));
  
  int [] fraction = {n, d};
  return fraction;
}

ArrayList<String[]> makeTable(String rad) {
  ArrayList<String[]> table = new ArrayList<String[]>();
  String[] labels = {"\u03B8", "sin " + "\u03B8", "cos " + "\u03B8"};  
  table.add(labels);
    
  int n = getFraction(rad)[0];
  int d = getFraction(rad)[1];
  
  for(int numerator=0; numerator / d <= 2; numerator = numerator + n) {
    float angle = float(numerator) / d;
    String[] row = {reduceFraction(numerator, d) , str(roundAny(sin(angle), 4)), str(roundAny(cos(angle), 4))};
    table.add(row);
  }
  
  return table;
}

void display(String rad) {
  ArrayList<String[]> table = makeTable(rad);
  for(int i=0; i < table.size(); i++) {
    String row = "";
    row = table.get(i)[0] + "/n"+ table.get(i)[1] + "/n" + table.get(i)[2];
    println(table.get(i)[0] + "/n"+ table.get(i)[1] + "/n" + table.get(i)[2]);
  }
}

void draw(String rad) {
  PFont myFont;
  myFont = createFont("Georgia", 32);
  ArrayList<String[]> table = makeTable(rad);
  textFont(myFont);
  text(table.get(0)[0] , width/2 - 150, (2)*32);
  text(table.get(0)[1] , width/2, (2)*32);
  text(table.get(0)[2] , width/2 + 150, (2)*32);
  text("------------------------------------" , width/2 - 150, (3)*32);
  
  for(int i=1; i < table.size(); i++) {
    String row = ""; 
    fill(255, 255, 255);
    text(table.get(i)[0] , width/2 - 150, (i+3)*32);
    fill(255,160,122);
    text(table.get(i)[1] , width/2, (i+3)*32);
    fill(0, 102, 153);
    text(table.get(i)[2] , width/2 + 150, (i+3)*32);
  }
}

void setup() {
  size(1200, 800);
  background(0);
  String incrementAngle = "2pi/3";
  draw(incrementAngle);
  noLoop();
}
