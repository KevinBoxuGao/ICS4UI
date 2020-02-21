String[] parts(String n) {
  String[] result = new String[2];
  int multiplyIndex = n.indexOf("x");
  if (multiplyIndex == -1) {
    result[0] = n;
    result[1] = "0";
  } else {
    result[0] = n.substring(0, multiplyIndex);
    result[1] = n.substring(multiplyIndex+4, n.length());
  }
  return result;
}

String multiplyInScientificNotation(String n1, String n2) {
  String[] result1 = parts(n1);
  String[] result2 = parts(n2);
  
  int tenExponent = int(result1[1]) + int(result2[1]);
   
  float value = float(result1[0]) * float(result2[0]);
  if (abs(value) > 10) {
    value = value / 10;
    tenExponent++;
  }
  
  String valueString = str(value);
  String exponentString = (tenExponent != 0) ? "10^" + str(tenExponent): "";
  return(valueString + exponentString);
}

void setup() {
  String[] inputs = loadStrings("input.txt");
  for(int i=0; i<inputs.length; i++) {
     String[] numbers = inputs[i].split(",");
     println(multiplyInScientificNotation(numbers[0], numbers[1]));
  }
  exit();
}
