String[] words = {"dad", "mom", "joe"};
PVector[] wordCoordinate = new PVector[words.length];
float[] k;
float urgency = 0.01;

void draw() {
  background(0);
  fill(255);
  for(int i=0; i < words.length; i++ ) {
    wordCoordinate[i].x += (mouseX - wordCoordinate[i].x)*k[i];
    wordCoordinate[i].y += (mouseY - wordCoordinate[i].y)*k[i];
    text(words[i], wordCoordinate[i].x, wordCoordinate[i].y);
  }
}

void setup() {
  size(800,800);
  PFont font = createFont("Arial", 32);
  textFont(font);
  k = new float[words.length];
  for(int i=0; i < words.length; i++ ) {
    wordCoordinate[i] = new PVector(random(width), random(height));
    k[i] = i*.005+.015;
  }
}
