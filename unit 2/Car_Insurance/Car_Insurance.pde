//GLOBAL VARIABLES
int age = 16;
String gender = "M";
int[][] prices = { {3000,2500},{1800,1200},{1400,1100},{2000,2000} };

//MAIN PROGRAM
void setup() {
  int genderIndex;
  if (gender == "M") {
    genderIndex = 0;
  } else {
    genderIndex = 1;
  }
  
  if (18 <= age && age <= 25) {
    println("Your Insurance is " + str(prices[0][genderIndex]));
  } else if (26 <= age && age <= 35) {
    println("Your Insurance is " + str(prices[1][genderIndex]));
  } else if (36 <= age && age <= 65) {
    println("Your Insurance is " + str(prices[2][genderIndex]));
  } else if (66 <= age) {
    println("Your Insurance is " + str(prices[3][genderIndex]));
  } else {
    println("Oops, you are not old enough to drive");
  }
    
  exit();
}
