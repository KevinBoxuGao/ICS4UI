float roundAny(float x, int d) {
  //code goes here
  if (d==0) {
    return round(x);
  } 
  float roundedValue;
  roundedValue = x * pow(10, d);
  roundedValue = round(roundedValue);
  roundedValue = roundedValue / pow(10, d);
  
  return roundedValue;
}

void setup() {
  float f = 45.62908;
  println( roundAny(f, 1) );  //should print 45.6
  println( roundAny(f, 2) );  //should print 45.63
  println( roundAny(f, 3) );  //should print 45.629
}
