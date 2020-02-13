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
  String[] labels = {"theta", "sin theta", "cos theta"};  
  table.add(labels);
    
  int n = getFraction(rad)[0];
  int d = getFraction(rad)[1];
  
  for(float numerator=0; numerator / d <= 2; numerator = numerator + n) {
    float angle = numerator / d;
    String[] row = {str(int(numerator)) + " " + str(d) , str(roundAny(sin(angle), 4)), str(roundAny(cos(angle), 4))};
    table.add(row);
  }
  
  return table;
}

void display(String rad) {
  ArrayList<String[]> table = makeTable(rad);
  for(int i=0; i < table.size(); i++) {
    String row = "";
    row = table.get(i)[0] + " " + table.get(i)[1] + " " + table.get(i)[2];
    println(row);
  }
}

void setup() {
  String incrementAngle = "2pi/3";
  display(incrementAngle);
  exit();
}
