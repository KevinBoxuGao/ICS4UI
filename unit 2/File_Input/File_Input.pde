void setup() {
  size(400, 800);
  String[] input = loadStrings("./input.txt");
  draw(input);
  PrintWriter pw = createWriter("output.txt");
  for(int i = 0; i < input.length; i++) {
    String[] inputCoord = input[i].split(" ");
    int xCoord = int(inputCoord[0]);
    int yCoord = height - int(inputCoord[1]);
    pw.println("Drew point " + "("  + str(xCoord) + ", " + str(yCoord) +")");
  }
 
  pw.close();
  noLoop();
}

void draw(String[] input) {
  for(int i = 0; i < input.length; i++) {
    String[] inputCoord = input[i].split(" ");
    int xCoord = int(inputCoord[0]);
    int yCoord = height - int(inputCoord[1]);
    circle(xCoord, yCoord, 5);
  }
}
