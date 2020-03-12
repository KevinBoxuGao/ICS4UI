class Dog {
  //FIELDS
  String name;
  String gender;
  String breed;
  String emoState;
  
  //CONSTRUCTOR
  Dog(String n , String g, String b) {
    this.name = n;
    this.gender = g;
    this.breed = b;
    this.emoState = "normal";
  }
  
  //METHODS/BEHAVIOURS
  void bark() {
    println("'Woof!' said", this.name);
  }
  
  void getTreat() {
    this.emoState = "happy";
  }
  
  void goToVet() {
    this.emoState = "nervous";
  }
  
  void describe() {
    println(this.name + " is a " + 
            this.gender + " " + this.breed + " and is currently feeling " + this.emoState);
  }  
}
