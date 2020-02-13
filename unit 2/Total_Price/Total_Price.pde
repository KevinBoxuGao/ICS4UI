void setup() {
  float total = 0;
  for(float start = 5; start <= 193.5; start += 0.5) {
    total += start;
  }
  exit();
  println(str(total));
}
