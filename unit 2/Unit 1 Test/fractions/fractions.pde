Float convertFracToDecimal(String fraction) {
  int slashIndex = fraction.indexOf("/"); 
  int n = (slashIndex != -1) ? int(fraction.substring(0, slashIndex)) : int(fraction) ;
  int d = (slashIndex != -1) ? int(fraction.substring(slashIndex + 1, fraction.length())) : 1;
  return float(n) / d;
}

void setup() {
  String[] fileLines = loadStrings("Fractions.txt");
  String[] firstRow = fileLines[0].split(",");
  
  String[][] fractionTable = new String[fileLines.length][firstRow.length];
  for(int i = 0; i < fileLines.length; i++) {
    String[] row = fileLines[i].split(",");
    for(int j=0; j<row.length; j++) {
      fractionTable[i][j] = row[j];
    }
  }
  
  //output to file
  PrintWriter pw = createWriter("Column sums.txt");
  
  //calculate sum
  for(int j=0; j<fractionTable[0].length; j++) {
    float total = 0;
    for(int i=0; i<fractionTable.length; i++) {
      total += convertFracToDecimal(fractionTable[i][j]);
    }
    pw.println("The sum of column " + str(j+1) + " is " + str(total));
    println("The sum of column " + str(j+1) + " is " + str(total));
  }
  pw.close();
  
  
  exit();
}
