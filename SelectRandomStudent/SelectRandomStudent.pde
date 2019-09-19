// ------------------------------------------------------------
// specifications and derived values
// ------------------------------------------------------------
final int SCREEN_WIDTH = 900;
final int SCREEN_HEIGHT = 700;
final String FILENAME = "studenten.txt";
final color BG_COLOR = #202020;
final int MESSAGE_TEXT_SIZE = 16;


// ------------------------------------------------------------
// program initialization
// ------------------------------------------------------------
void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  stateSetup(FILENAME, SCREEN_WIDTH, SCREEN_HEIGHT);

  // don't continouesly call draw() the screen (to save CPU time and battery)
  // redraw only when state is changed (e.g. see keyPressed())
  noLoop();
}


// ------------------------------------------------------------
// view
// ------------------------------------------------------------
void draw() {
  background(BG_COLOR);

  pushStyle();
  textSize(stateGetStudentTextSize());
  textAlign(CENTER, CENTER);
  text(stateGetCurrentStudent(), width / 2, height / 2 - textDescent());
  popStyle();

  pushStyle();
  textSize(MESSAGE_TEXT_SIZE);
  textAlign(CENTER, CENTER);
  text("Press SPACE to select new student", width / 2, height - textDescent() - textAscent());
  popStyle();
}


// ------------------------------------------------------------
// events
// ------------------------------------------------------------
void keyPressed() {
  if (key == ' ') {
    stateSetNextStudent();

    // state has (possibly) changed, redraw 
    redraw();
  }
}
