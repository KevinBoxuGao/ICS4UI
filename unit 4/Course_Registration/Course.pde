import java.util.Map;

class Course {
  String courseCode;
  String teacher;
  ArrayList<Student> students;
  hashMap<Student,Integer> finalMarks;
  
  Course(String c, String t) {
    this.courseCode = c;
    this.teacher = t;
    this.students = new ArrayList<Student>();
    this.finalMarks = new HashMap<Student,Integer>();
  }
  
  addStudent(Student s) {
    this.students.add(s);
    this.finalMarks.put(s, -1);
  }
  
  printStudents() {
    println(this.students);
  }
  
  finalMark(student s, int finalMark) {
    this.finalMarks.put(s, finalMark);
  }
  
  printStudentsMarks() {
    println(courseCode +" Marks:");
    for(int i=0; i<students.length; i++) {
      int finalMark = this.finalMarks.get(students[i]);
      if(finalMark==-1) {
        println(students[i].name + ": " + "None");
      } else {
        println(students[i].name + ": " + str(finalMark)); 
      }
    }
  }
}
