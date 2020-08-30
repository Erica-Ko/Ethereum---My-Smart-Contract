pragma solidity 0.4.18 <= 0.6.12;

contract schoolMarks {
    string studentName;
    int studentID;
    string classOfStudent;
    string subjects;
    int marks;
    int credits;
    int gpa;
    
    function schoolMarks (string newStudentName, int newStudentID, string newClassOfStudent, string newSubjects, 
    int newMarks, int newCredits, int newGpa) public {
        studentName = newStudentName;
        studentID = newStudentID;
        classOfStudent = newClassOfStudent;
        subjects = newSubjects;
        marks = newMarks;
        credits = newCredits;
        gpa = newGpa;
    }
    
    function getSchoolMarks () public view returns (string, int, string, string, int, int, int) {
        return(studentName, studentID, classOfStudent, subjects, marks, credits, gpa);
    }
}
