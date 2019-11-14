// ------------------------------------------------------------
// state
// ------------------------------------------------------------
StringList students;         // List with all student names.
StringList studentsShuffled; // Shuffled list of student names to step through for 'new random student'.
boolean[] studentPresence;
IntDict studentLookupbyname;

float studentTextSize;       // Optimized text size to display any student name.
int currentStudent = -1;     // Current student index of list.

// setup state with initial values
void stateSetup(String filename, int screenWidth, int screenHeight) {
  // read file with student names and cleanup list 
  String[] lines = trim(loadStrings(filename));
  students = new StringList(lines);

  students.removeValues("");
  studentsShuffled = students.copy();
  studentsShuffled.shuffle();
  studentTextSize = getTextSizeForBoundingBox(students, screenWidth, screenHeight);

  // Maak apart array aan voor aanwezigheid van elke student (in originele/ongeshuffelde studentenlijst).
  // (bij gebrek aan mogelijkheid tot object-georienteerd programmeren).
  studentPresence = new boolean[students.size()];
  // Initialiseer aanwezigheid voor alle studenten op waar.
  for(int i = 0; i<students.size(); i++) {
    studentPresence[i] = true;
  }
  
  // Load original student array into dictionary to allow searching the index in it by student name.
  studentLookupbyname = students.getOrder(); //<>//
}

// get current student name or empty string if no current student 
String stateGetCurrentStudent() {
  return currentStudent != -1 ? studentsShuffled.get(currentStudent) : "";
}

float stateGetStudentTextSize() {
  return studentTextSize;
}

void stateSetNextStudent() {
  boolean isAanwezig;
  do {
    currentStudent = modulo(currentStudent+1, studentsShuffled.size());
    // Check of huidige student als afwezig staat genoteerd in originele studentenlijst (presencelist).
    int indexInOrg = indexInUnshuffledList(currentStudent);
    isAanwezig = studentPresence[indexInOrg];
    // println("currentStudent: ", currentStudent, "naam: ", studentsShuffled.get(currentStudent), "indexInOrg: ", indexInOrg, " Naam in org: ", students.get(indexInOrg)," isAanwezig: ", isAanwezig);
  } while (!isAanwezig);
  redraw();
}

int indexInUnshuffledList(int indexInShuffled) {
  return studentLookupbyname.get(studentsShuffled.get(currentStudent));
}

boolean zijnAlleStudentenAfwezig() {
  for(int i=0; i<studentPresence.length; i++) {
    // Als er ook maar 1 student aanwezig is, dan zijn niet alle studenten afwezig :).
    if (studentPresence[i]) {
      return false;
    }
  }
  return true;
}

void toggleStudentPresence(int index) {
  if (index>=0 && index<studentPresence.length) {
    studentPresence[index] = !studentPresence[index];
    // Check nog of je niet toevallig de laatste aanwezige student uitvinkte, toggle dan weer terug.
    if(!studentPresence[index]) {
      boolean zijnAlleStudentenAfwezig = zijnAlleStudentenAfwezig();
      if (zijnAlleStudentenAfwezig) {
        studentPresence[index] = !studentPresence[index];
        flashWarningColor=true;
      }
    }
  }
}

void toggleAllStudents() {
  for(int i=0; i<studentPresence.length; i++) {
    toggleStudentPresence(i);
  }
}
