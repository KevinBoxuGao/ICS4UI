String joinWordsIntoOneBigWord(String[] words) {
  String word = "";
  for(int i=0; i< words.length; i++) {
    word += words[i];
  }
  return word;
}

int countNumberOfFalses(boolean[] outcomes) {
  int numFalses = 0;
  for(int i=0; i< outcomes.length; i++) {
    if(!outcomes[i]) {
      numFalses += 1;
    }
  }
  return numFalses;
}

int[] multiplesOf5Between(int n1, int n2) {
  int numMultiples = ((n2 + (n2 % 5))-(n1 + (n1 % 5))) / 5;
  int[] multiples = new int[numMultiples];
  for(int i=0; i<numMultiples; i++){
    multiples[i] = (n1 + 5 - (n1 % 5))+(5*i);
  }
  return multiples;
}

void setup() {
  String[] myWords = {"CS", "is", "cooler", "than", "Chemistry"};
  String bigWord = joinWordsIntoOneBigWord(myWords);
  println(bigWord);
  
  boolean[] outcomes = {true,  true, false, false ,false, true, true, false};
  int numFails = countNumberOfFalses(outcomes);
  println(numFails);
  
  int[] mults = multiplesOf5Between(63, 99);
  printArray(mults);
}
