// ------------------------------------------------------------
// specifications and derived values
// ------------------------------------------------------------
final int SCREEN_WIDTH = 900;
final int SCREEN_HEIGHT = 700;
final String FILENAME = "studenten.txt";

final color BG_COLOR = #202020; // Donkergrijs.
final color WARNING_COLOR = #ff0000; // Rood.
final color TEXT_COLOR = 255; // Wit.
final color TEXT_COLOR_NOT_PRESENT = #A08080;
final color HOOVER_COLOR = #ffff30; // Oranje.

final int MESSAGE_TEXT_SIZE = 16;

final int MARGIN = 50;
int lineHeight;
int hooveredStudentInList = -1;
boolean zijnAlleStudentenAfwezig = false;

boolean isShuffling = false;
boolean flashWarningColor = false;
boolean showStudentList = false;

// ------------------------------------------------------------
// Program initialization.
// ------------------------------------------------------------
void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() { 
  // runUnitTests();

  textAlign(CENTER, CENTER);
  stateSetup(FILENAME, SCREEN_WIDTH, SCREEN_HEIGHT);

  // Hou ruimte voor marge boven en beneden en 4 extra witregels (ook ivm tekst 'druk op L...').
  lineHeight = (SCREEN_HEIGHT-2*MARGIN)/(students.size()+4);

  // Don't continuously call draw() the screen (to save CPU time and battery)
  // redraw only when state is changed (e.g. see keyPressed()).
  noLoop();
}


// ------------------------------------------------------------
// view
// ------------------------------------------------------------
void draw() {
  if (flashWarningColor) {
    background(WARNING_COLOR);
    flashWarningColor=false;
    textSize(MESSAGE_TEXT_SIZE);
    if (!isShuffling) {
        text("Unknown key!", width/2, height-textDescent()-textAscent());
    }
    loop(); // To allow updating screen without keypress resume standard loop.
  } else {
    noLoop(); // Stop looping again if no flashing is required.
    background(BG_COLOR);
    if (showStudentList) {
      drawStudentList();
    } else {
      
      /* TODO: Visual shuffling code, maar dit moet binnen de draw() methode gebeuren, anders zie je niks.
      int aantal = studentsShuffled.size();
      isShuffling = true;
      final int AANTAL_STUDENTEN_TERUG = 10;
      int aantalStudentenTerug = min(AANTAL_STUDENTEN_TERUG, aantal);
      int start = modulo(currentStudent-aantalStudentenTerug, aantal);
      int eindStudent = currentStudent;
      for(int i=0; i<aantalStudentenTerug; i++) {
        currentStudent = modulo(start+i, aantal);
        println("draw student " + currentStudent);
        redraw();
      }
      isShuffling = false;
      currentStudent = eindStudent;
      // EINDE TODO Visual shuffling.
      */
      
      textSize(stateGetStudentTextSize());
      text(stateGetCurrentStudent(), width/2, height/2-textDescent());
    
      textSize(MESSAGE_TEXT_SIZE);
      if (!isShuffling) {
        float textDescent = textDescent();
        float textAscent = textAscent();
        text("Druk SPATIE voor een nieuwe random student (L voor lijst, X als student afwezig)", width/2, height-textDescent-textAscent);
      }
    }
  }
  toonMeldingAlsAlleStudentenAfwezig();
}

void drawStudentList() {
    textSize(MESSAGE_TEXT_SIZE);
  int y = MARGIN;
  textAlign(LEFT, TOP);
  text("Studenten: ", MARGIN, y);
  y += lineHeight;
  for(int i = 0; i<students.size(); i++) {
    // Use orange colour for student the mouse is hoovering on (if any).
    if(i==hooveredStudentInList) {
      fill(HOOVER_COLOR);
    } else {
      if(studentPresence[i]) {
        fill(TEXT_COLOR);
      } else {
        fill(TEXT_COLOR_NOT_PRESENT);
      }
    }
    text((i<10 ? "0" : "") + i + ". " + (studentPresence[i] ? "V" : "X") + " " + students.get(i) , MARGIN, y);
    y += lineHeight;
    fill(TEXT_COLOR);
  }
  textAlign(CENTER, CENTER);
  text("Klik een naam om aanwezigheid te togglen (V=aanwezig, X=afwezig)", width/2, height-textDescent()-2*textAscent());
  text("Druk nogmaals L om random student weer te laten zien", width/2, height-textDescent()-1*textAscent());
}

void toonMeldingAlsAlleStudentenAfwezig() {
  if(zijnAlleStudentenAfwezig) {
    fill(WARNING_COLOR);
    text("Je mag NIET alle studenten als afwezig markeren!", width/2, height-textDescent()-3*textAscent());
    fill(TEXT_COLOR);
  }
}

// ------------------------------------------------------------
// events
// ------------------------------------------------------------
void keyPressed() {
  if(!isShuffling) {
    switch (key) {
      case ' ':
        // Pak alleen volgende student als je momenteel niet de lijst toont.
        if (!showStudentList) {
          stateSetNextStudent();
        }
        break;
      case 'l':
      case 'L':
        // Toggle tonen list (werkt alleen niet als alle studenten afwezig zijn gemarkeerd).
        if (!zijnAlleStudentenAfwezig) {
          showStudentList=!showStudentList;
        } else {
          // Als je probeert terug te togglen naar random-naam-scherm met alle studenten afwezig krijg je rode flits.
          flashWarningColor=true;
        }
        break;
      case 'a':
      case 'A':
        toggleAllStudents();
        zijnAlleStudentenAfwezig = zijnAlleStudentenAfwezig();
        break;
        case 'x':
        case 'X':
        if (!showStudentList) {
          int indexInOrg = indexInUnshuffledList(currentStudent);
          toggleStudentPresence(indexInOrg);
          stateSetNextStudent();
        }
        break;
      default:
        // Als je niet toegewezen key gebruikt krijg je een rode flits.
        flashWarningColor=true;
        break;
    }
  } else {
    // Als je toets indrukt tijdens shuffle animatie krijg je een rode flits (TODO: Animatie).
    flashWarningColor=true;
  }

  // State is aangepast: redraw.
  redraw();
}

void mouseMoved() {
  hooveredStudentInList = determineStudentIndexFromMousePosition(mouseY);
  redraw();
}

int determineStudentIndexFromMousePosition(int y) {
  int result = (y-MARGIN)/lineHeight-1;

  // Reset als je onder of boven marge zit.
  if (result>students.size() || result<0) {
    result = -1;
  }
  return result;
}

void mouseClicked() {
  // Draai aanwezigheid om (alleen als pagina met lijst met studenten actief is).
  if (showStudentList) {
    int index = determineStudentIndexFromMousePosition(mouseY);
    toggleStudentPresence(index);
    zijnAlleStudentenAfwezig = zijnAlleStudentenAfwezig();
    redraw();
  }
}
