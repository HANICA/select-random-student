// calculate text size to fit largest line in box
// adapted from https://forum.processing.org/two/discussion/13105/how-to-make-a-string-of-any-length-fit-within-text-box
float getTextSizeForBoundingBox(StringList lines, int boxWidth, int boxHeight) {
  final int PROCESSING_DEFAULT_TEXT_SIZE = 12;

  // find maximum text width of all lines
  float maxTextWidth = 0;
  for (String line : lines) {
    maxTextWidth = textWidth(line) > maxTextWidth ? textWidth(line) : maxTextWidth;
  }

  // calculate minimum size to fit largest line by width
  float minSizeWidth = PROCESSING_DEFAULT_TEXT_SIZE / maxTextWidth * boxWidth;
  // calculate minimum size to fit largest line by height
  float minSizeHeight = PROCESSING_DEFAULT_TEXT_SIZE / (textDescent() + textAscent()) * boxHeight;

  // return the minumum size of width or height
  return min(minSizeWidth, minSizeHeight);
}
