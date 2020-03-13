class Student {
  String name;
  int studentNumber;
  int gradeLevel;
  Course[] timetable;
  
  Student(String n, int id, int g) {
    this.name = n;
    this.studentNumber = id;
    this.gradeLevel = g;
    this.timetable = new Course[4];
  }
  
  void printIdentification() {
    println("name: " + this.name);
    println("grade: " + str(this.gradeLevel));
    println("Student Number: " + str(this.studentNumber));
  }
  
  void printTimetable() {
    println("Courses:");
    for(int i; i<4; i++) {
      if(this.timetable[i] == null) {
        println("spare");
      } else {
        println(str(this.timetable[i].courseCode));
      }
    }
  }
  
  void printMarks() {
    println("Marks:");
    for(int i; i<4; i++) {
      if(this.timetable[i] != null) {
        println(str(this.timetable[i].courseCode) + ": " + );
      }
    }
  }
}
