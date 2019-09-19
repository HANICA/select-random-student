// ------------------------------------------------------------
// state
// ------------------------------------------------------------
StringList studenten;     // list with all student names
float studentTextSize;    // optimized text size to display any student name
int currentStudent = -1;  // current student index of list


// setup state with initial values
void stateSetup(String filename, int screenWidth, int screenHeight) {
  // read file with student names and cleanup list 
  String[] lines = trim(loadStrings(filename));
  studenten = new StringList(lines);
  studenten.removeValues("");
  studenten.shuffle();

  studentTextSize = getTextSizeForBoundingBox(studenten, screenWidth, screenHeight);
}

// get current student name or empty string if no current student 
String stateGetCurrentStudent() {
  return currentStudent != -1 ? studenten.get(currentStudent) : "";
}

float stateGetStudentTextSize() {
  return studentTextSize;
}

void stateSetNextStudent() {
  currentStudent = ++currentStudent % studenten.size();
}
