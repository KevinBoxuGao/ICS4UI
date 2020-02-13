void setup() {
  for(int i = 0; i <= 360; i++) {
    float left = sin(radians(i));
    float right = 3*sin(radians(i)/3) - pow((4*(sin(radians(i)/3))), 3);
    println(str(left) + " " + str(right));
  }
}
