HScrollbar hs1, hs2;

int rectX, rectY;
int rectSize = 20;
float velocidad = 0;
color rectColor,baseColor,currentColor;
boolean rectOver = false;
String texto = "";
PFont fontA;
void setup()
{
  hs1 = new HScrollbar(0, 20, width, 10, 10);
  size(400, 400);
  smooth();
  rectColor = color(0);
  baseColor = color(102);
  currentColor = baseColor;
  rectX = 10;
  rectY = 10;
  ellipseMode(CENTER);
  fontA = loadFont("Serif-48.vlw");
  textFont(fontA, 32);
}

void draw()
{
  velocidad = hs1.getPos();
  update(mouseX, mouseY);
  rect(rectX, rectY, rectSize, rectSize);
  text(velocidad, 30, 60);
   hs1.update();
   hs1.display();
}

void mousePressed()
{
  if(rectOver) {
    texto = "hola";
  }
}

void update(int x, int y)
{
if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
  } else {
     rectOver = false;
  }
}

boolean overRect(int x, int y, int width, int height) 
{
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

class HScrollbar
{
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;         // x and y position of bar
  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (int xp, int yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if(over()) {
      over = true;
    } else {
      over = false;
    }
    if(mousePressed && over) {
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
    }
    if(locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if(abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if(mouseX > xpos && mouseX < xpos+swidth &&
    mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    fill(255);
    rect(xpos, ypos, swidth, sheight);
    if(over || locked) {
      fill(153, 102, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
