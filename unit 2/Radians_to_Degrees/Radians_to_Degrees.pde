int numerator(String radian) {
  int pIndex = radian.indexOf("p");
  int result = int((pIndex == 0) ? "1" : radian.substring(0, pIndex));
  return result;
}

int denominator(String radian) {
  int slashIndex = radian.indexOf("/");
  int result = int((slashIndex == -1) ? "1" : radian.substring(slashIndex +1 , radian.length()));
  return result;
}

void setup() {
  String[] input = loadStrings("input.txt");
  String radianAngle = input[0];
  int n = numerator(radianAngle);
  int d = denominator(radianAngle);
  float degrees = n*180/float(d); 
  
  PrintWriter pw = createWriter("output.txt");
  pw.println(degrees);
  pw.close();
  exit();
}
