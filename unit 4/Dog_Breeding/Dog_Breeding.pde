void setup() {
  Dog haley = new Dog("Haley", "female", "husky");
  Dog ralph = new Dog("Ralph", "male", "golden retriever");
  
  Breeder cameron = new Breeder("Cameron", 3);
  cameron.describe();
  
  Dog[] myLitter = cameron.breedPair( haley, ralph );
  
  for(int i=0; i < myLitter.length; i++) {
    myLitter[i].describe();
  }
  exit();
}
