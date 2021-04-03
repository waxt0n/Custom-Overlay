class typeBox {
  int x;
  int y;
  float w;
  float h;

  typeBox(int _x, int _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  void run(String imput) {
   pushStyle();
   fill(foreground);
   rectMode(CENTER);
   textAlign(LEFT,CENTER);
   textSize(h);
   rect(x,y,w,h,h/4);
   fill(textcolor);
   text(imput,x-w/2,y-2);
   popStyle();
  }
}

void keyPressed() {
  if (key == CODED) {
    
  }
}
