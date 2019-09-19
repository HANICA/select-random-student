void runUnitTests() {
  testModulo();
  testAlleStudentenAfwezig();
}

void testModulo() {
  println("modulo(-10, 30)==20 ?", modulo(-10, 30)==20);
  println("modulo(10, 30)==10 ?", modulo(10, 30)==10);
  println("modulo(10, 10)==0 ?", modulo(10, 10)==0);
  println("modulo(3, 10)==3 ?", modulo(3, 10)==3);
  println("modulo(-3, 10)==7 ?", modulo(-3, 10)==7);
}

void testAlleStudentenAfwezig() {
  studentPresence = new boolean[] { false, false, false };
  println("zijnAlleStudentenAfwezig() is 'true' als allemaal niet aanwezig?", zijnAlleStudentenAfwezig()==true);

  studentPresence = new boolean[] { false, false, true };
  println("zijnAlleStudentenAfwezig() is 'false' als eentje aanwezig?", zijnAlleStudentenAfwezig()==false);

  studentPresence = new boolean[] { true, true, true };
  println("zijnAlleStudentenAfwezig() is 'false' als allemaal aanwezig?", zijnAlleStudentenAfwezig()==false);
}
