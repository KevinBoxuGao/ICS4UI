class Breeder {
  //fields
  String name;
  int yearsExperience;
  String[] puppyNames = {"Woofgang", "Nuisance", "Goofball", "Sir Barksalot", "Lucky", 
                        "Unlucky", "Boolean", "Slope", "Torus", "Helix", "Arctan", "Cosine", "Squared"};
  
  //constructor
  Breeder(String n, int y) {
    this.name = n;
    this.yearsExperience = y;
  }
  
  //behaviours
  void describe() {
      println(this.name, "has been a breeder for", this.yearsExperience, "years");
  }
  
  Dog[] breedPair(Dog m, Dog f) {
    //1. Pick a random litter size
    //2. Create of empty array of Dog objects of that size
    //3. For i = 0 up to size:
    //      a. pick a random puppy name, a random weight & a random gender
    //      b. make a new Dog object with that data and add that Dog object to the array
    //4. Return the resulting array
    
    Dog[] litter;
    //check if there is one male and female dog
    if(m.gender!=f.gender) {
      int litterSize = round(random(0, puppyNames.length));
      litter = new Dog[litterSize];
      for(int i=0; i<litterSize; i++) {
        String name = puppyNames[int(random(0, puppyNames.length))];
        String gender = (round(random(0,1)) == 1)? "M" : "F" ;
        String breed = (round(random(0,1)) == 1)? m.breed : f.breed ;
        litter[i] = new Dog(name, gender, breed);
      }
    } else {
      litter = new Dog[0];
    }
 
    return litter; //replace this with the right thing
  }
}
