// Get yerself some TOXICLIBS: http://toxiclibs.org/
import toxi.color.*;
import toxi.math.*;

PImage source;
PGraphics cover;
int numRows = 18;
int numCols = 18;
float dotSize;
int dotSpace = 5;

// The album covers can be any size, really. We're going to scale them to the size of the movie.
String[] filenames = {
"1-murmur.jpg","2-reckoning.jpg","3-fables.jpg","4-lifes.jpg","5-document.jpg","6-green.jpg","7-outoftime.jpg","8-automatic.jpg","9-monster.jpg","10-newadventures.jpg","11-up.jpg","12-reveal.jpg","13-aroundthesun.jpg","14-accelerate.jpg","15-collapse.jpg"
};


void setup() {
  // 1000 seems like a nice round number.
  size(1000, 1000);
  // How big are those dots?
  dotSize = width / numRows;
  noStroke();
  ellipseMode(CORNER);
  // This is a whole lot of greasy for-loop action.
  // I'm sure there's a better way to do this, but I'm a busy man.
  for (int in = 0; in<filenames.length; in++) {
    background(255);
    source = loadImage(filenames[in]);
    // Create a PGraphics object and draw the source into it at the proper width/height.
    cover = createGraphics(width, height);
    cover.beginDraw();
    cover.image(source, 0, 0, width, height);
    cover.endDraw();
    // Rows and columns of dots.
    for (int ix=0; ix<numRows; ix++) {
      for (int iy=0; iy<numCols; iy++) {
        int[] colors = new int[(int)(dotSize*dotSize)];
        int index = 0;
        // Add each pixel's value to an int array. Only read the pixels in this particular quad.
        for (int iix=(int)(ix*dotSize); iix < (ix*dotSize)+dotSize; iix++) {
          for (int iiy=(int)(iy*dotSize); iiy < (iy*dotSize)+dotSize; iiy++) {
            colors[index] = cover.get((int)(ix * dotSize), (int)(iy * dotSize));
            index++;
          }
        }
        // Create a color list from our int array. Use its average as the fill color.
        ColorList colorList = new ColorList(colors); 
        fill(colorList.getAverage().toARGB());
        ellipse(ix * dotSize +dotSpace, iy*dotSize+dotSpace, dotSize-dotSpace, dotSize-dotSpace);
      }
    }
    // SAVE IT!
    saveFrame("output/"+filenames[in]+".tif");
  }
  // We're not displaying anything, so just exit.
  exit();
}

