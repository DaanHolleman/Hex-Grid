//Full code for the project.
//lines and snakes are the same thing (I stole code from another project I made, but decided to call them lines this time.)
//To run the project, you probably need Processing 3.0 ( I didnt want to upload a full exe file.)

ArrayList<Grid> lines;
float maxWidth;

  	//is called at the beginning once
void setup() {
  fullScreen();
  background(0);
  maxWidth = sqrt( width * width + height * height );
  lines = new ArrayList<Grid>();
}

  //is called every frame
void draw() {
    //draw a black transparent rectangle 
  noStroke();
  fill(0,0,0,40);
  rect(-1,-1,width+2,height+2);
  
    //add two new snakes.
  newSnake(false);
  newSnake(false);
  
    //animate the snakes
  for ( Grid index : lines) {
    index.move();
  }
    //delete dead snakes
  for( int i = 0; i < lines.size(); i ++ ) {
    Grid g = lines.get(i);
    if(g.direction.size() == 0) lines.remove(i);
  }
}

  //pretty self-explanatory
void newSnake(boolean mouse) {
  float centerX = getXY(mouse,"X");
  float centerY = getXY(mouse,"Y");
  
  int colorSelector = #7DF9FF;
  
  lines.add( new Grid(centerX, centerY, colorSelector));
}

  //Not really efficient; would've written it differently now using switch() (also the boolean is redundant)  
public float getXY(boolean mouse, String XY) {
  if(mouse) {
    if(XY == "X") return mouseX;
    else return mouseY;
  }
  else {
    if(XY == "X") return width/2;
    else return height/2;
  }
}

//===========================================================//

class Grid {
  float x, y, l, counter, delta, endCounter;
  FloatList direction;
  int Color;
  
  Grid(float x_, float y_, int c) {
    x = x_;
    y = y_;
    l = 50;
    Color = c;
    counter = 0;
    endCounter = 0;
    delta = 1;
    direction = new FloatList();
      //store a initial direction (0deg,120deg,240deg) in rad;
    direction.append(2 * floor(random(1, 4)) * PI / 3);
  }

  void move() {
    counter += delta;
      //not entirely sure why this works, but it works.
    if (counter / 1.5 == round(counter/1.5)) {
      if (direction.size() != 0) {
        
        float lastDir = direction.get(direction.size()-1);
        float rand = (floor(random(0, 1)-0.5)*2+1) * PI / 3;
        
        switch(round(random(0, 1))) {
        case 0:
          direction.append( lastDir + rand);
          break;
        case 1:
          direction.append( lastDir - rand);
          break;
        }
      }
    }
    float x1 = x;
    float y1 = y;
    
    for ( int i = 0; i < direction.size(); i++) {
      float x2 = x1 + cos(direction.get(i)) * l;
      float y2 = y1 + sin(direction.get(i)) * l;
      stroke(Color);
      strokeWeight((sqrt(i+1)*2 - 1) * (l/25));
      line(x1, y1, x2, y2);
      x1 = x2;
      y1 = y2;
    }
    if (counter >= 40 && direction.size() > 0) {
      endCounter += delta;
      if (endCounter / 1 == round(endCounter/1)) {
        x += cos(direction.get(0)) * l;
        y += sin(direction.get(0)) * l;
        direction.remove(0);
      }
    }
  }
}
