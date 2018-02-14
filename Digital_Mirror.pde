/*

the Birds
Danielle McPhatter | 2018 | Digital Mirror Assignment

Takes the average color value of each row and assigns that color to a 
quadrilateral shape that is drawn in a random location with random size 
and coordinates during each frame.

The randomness creates movement, with shadows to emphasize this,
to make the shapes look like birds flying in the same direction.
 
*/


import processing.video.*;

Capture camera;

int offset = 50;
int Soffset = 5;


void setup() {
  size(1280, 720);
  frameRate(30);
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    exit();
  }
  camera = new Capture(this, cameras[0]);
  camera.start();
}


void draw() {
  if (camera.available()) {
    background(#f3ead7);
    camera.read();
    
    camera.loadPixels();  
    for (int y=0; y<height; y++) {
      float average = 0;
      
      for (int x=0; x<width; x++) {
        int index = (width-x-1) + y*width; 
        average += index;
      }
      // Takes the average of the color of pixels in one row, this will be used for the fill()
      average = average/width;
      noStroke();
      
      // Creating Points for Quad Function
      int seedX = int(random(width));
      int seedY = int(random(height));
      int X2offset =  seedX + int(random(offset));
      int Y2offset =  seedY + int(random(offset));
      int X3offset =  seedX + int(random(offset));
      int Y3offset =  seedY + int(random(offset));
      int X4offset =  seedX + int(random(offset));
      int Y4offset =  seedY + int(random(offset));
      
      // For Drawing Shadows
      fill(0,150);
      quad(seedX, seedY, X2offset + Soffset, Y2offset + Soffset, X3offset + Soffset, Y3offset + Soffset, X4offset + Soffset, Y4offset + Soffset);
      
      // Drawing the Shapes
      fill(camera.pixels[int(average)]);
      quad(seedX, seedY, X2offset, Y2offset, X3offset, Y3offset, X4offset, Y4offset);
    }
  }
}