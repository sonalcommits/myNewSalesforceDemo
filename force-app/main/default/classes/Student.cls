public class Student {
    public String studentName; //Instance variable- every students gets their own name. 
    public static Integer totalStudentCount=0; //Static variable - the entire batch will have one total student counter.
    public Student(String name) // constructor
    {
        studentName=name;
        totalStudentCount++;
        System.debug('Total count of Student '+totalStudentCount);

    }
    
    public static void printName()
    {
        System.debug('My name is Sonal');
    }

}