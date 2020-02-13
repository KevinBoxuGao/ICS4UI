//GLOBAL VARIABLES
boolean fermat = true;
String course = "MHF4UX";
int mark = 99;

//MAIN PROGRAM
void setup() {
  if (fermat) {
    if (course == "MHFUX") {
      if (mark >= 80) {
        println("You qualify");
      } else {
        println("You Do Not Qualify");
      }
    }
    else if (course == "MHF4UI") {
      if (mark >= 90) {
        println("You qualify");
      } else {
        println("You Do Not Qualify");
      }
    }
    else {
      println("You Do Not Qualify");
    }
  } else {
    println("You Do Not Qualify");
  }
  

  exit();
}
