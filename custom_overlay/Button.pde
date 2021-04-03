class Button { //one option for a button class
  //Button class by Palmer
  float X;
  float Y;
  float buttonWidth;
  float buttonHeight;
  float borderWeight = 10;
  color primaryColor = #5D5D5D;
  color textColor = #FFFFFF;
  float textSize = 30;
  String text = "";
  PFont font;
  boolean enabled = true;
  boolean pressed = false;
  boolean justPressed = false;
  boolean click = false;
  float clickX;
  float clickY;
  boolean mouseWasPressed = false;
  boolean visible = true;
  boolean arrowOn = false;
  int arrowDir = 0;
  boolean borderOn = true;
  color pressedColor = 256;
  color hoveredColor = 256;
  PGraphics drawTo;
  editInt offsetX;
  editInt offsetY;
  boolean useG=false;

  Button(float _X, float _Y, float _buttonWidth, float _buttonHeight) {
    X = _X;
    Y = _Y;
    buttonWidth = _buttonWidth;
    buttonHeight = _buttonHeight;
    font = createFont("Lucida Sans Regular", textSize);
    drawTo=g;
    useG=true;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
  }
  Button(float _X, float _Y, float _buttonWidth, float _buttonHeight, PGraphics _drawTo, editInt _offsetX, editInt _offsetY) {
    this(_X, _Y, _buttonWidth, _buttonHeight);
    drawTo=_drawTo;
    offsetX=_offsetX;
    offsetY=_offsetY;   
    useG=false;
  }
  void detectClick() {
    if (mousePressed && !mouseWasPressed) {
      clickX = (mouseX-offsetX.val);
      clickY = (mouseY-offsetY.val);
      mouseWasPressed = true;
    }

    click = false;
    if (mousePressed && clickX >= X && clickX <= X + buttonWidth && clickY >= Y && clickY <= Y + buttonHeight) {
      pressed = true;
    } else {
      pressed = false;
    }

    if (pressed) {
      justPressed = true;
    }

    if (justPressed && !pressed) {
      if (!mousePressed && (mouseX-offsetX.val) >= X && (mouseX-offsetX.val) <= X + buttonWidth && (mouseY-offsetY.val) >= Y && (mouseY-offsetY.val) <= Y + buttonHeight) {
        click = true;
      }
      justPressed = false;
    }

    mouseWasPressed = mousePressed;
  }

  void drawText() {
    drawTo.pushStyle();
    drawTo.textAlign(CENTER, CENTER);
    drawTo.textFont(font);
    drawTo.textSize(textSize);
    drawTo.fill(textColor);
    drawTo.text(text, X + buttonWidth / 2, Y + buttonHeight / 2);
  }

  void drawArrow() {
    drawTo.pushStyle();
    drawTo.stroke(textColor);
    if (arrowDir == 0) {
      drawTo.line(X + .25 * buttonWidth, Y + .5 * buttonHeight, X + .75 * buttonWidth, Y + .5 * buttonHeight + .5 * buttonWidth);
      drawTo.line(X + .25 * buttonWidth, Y + .5 * buttonHeight, X + .75 * buttonWidth, Y + .5 * buttonHeight - .5 * buttonWidth);
    }
    if (arrowDir == 1) {
      drawTo.line(X + .5 * buttonWidth, Y + .25 * buttonHeight, X + .5 * buttonWidth + .5 * buttonHeight, Y + .75 * buttonHeight);
      drawTo.line(X + .5 * buttonWidth, Y + .25 * buttonHeight, X + .5 * buttonWidth - .5 * buttonHeight, Y + .75 * buttonHeight);
    }
    if (arrowDir == 2) {
      drawTo.line(X + .75 * buttonWidth, Y + .5 * buttonHeight, X + .25 * buttonWidth, Y + .5 * buttonHeight + .5 * buttonWidth);
      drawTo.line(X + .75 * buttonWidth, Y + .5 * buttonHeight, X + .25 * buttonWidth, Y + .5 * buttonHeight - .5 * buttonWidth);
    }
    if (arrowDir == 3) {
      drawTo.line(X + .5 * buttonWidth, Y + .75 * buttonHeight, X + .5 * buttonWidth + .5 * buttonHeight, Y + .25 * buttonHeight);
      drawTo.line(X + .5 * buttonWidth, Y + .75 * buttonHeight, X + .5 * buttonWidth - .5 * buttonHeight, Y + .25 * buttonHeight);
    }
    drawTo.popStyle();
  }

  void display() {
    if (enabled) {
      detectClick();
    }
    if (!useG) {
      drawTo.beginDraw();
    }
    drawTo.pushStyle();
    drawTo.noStroke();
    drawTo.colorMode(HSB);
    if (pressed) {
      if (pressedColor == 256) {
        drawTo.fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30, alpha(primaryColor));
        drawTo.stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30, alpha(primaryColor));
      } else {
        drawTo.fill(pressedColor);
        drawTo.stroke(pressedColor);
      }
    } else if (enabled && (mouseX-offsetX.val) >= X && (mouseX-offsetX.val) <= X + buttonWidth && (mouseY-offsetY.val) >= Y && (mouseY-offsetY.val) <= Y + buttonHeight) {
      if (hoveredColor == 256) {
        drawTo.fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25, alpha(primaryColor));
        drawTo.stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25, alpha(primaryColor));
      } else {
        drawTo.fill(hoveredColor);
        drawTo.stroke(hoveredColor);
      }
    } else {
      drawTo.fill(primaryColor);
      drawTo.stroke(primaryColor);
    }
    drawTo.strokeCap(SQUARE);
    drawTo.strokeWeight(borderWeight);
    if (!borderOn) {
      drawTo.noStroke();
    }
    drawTo.rect(X, Y, buttonWidth, buttonHeight);
    drawText();
    drawTo.popStyle();
    drawTo.popStyle();
    if (!useG) {
      drawTo.endDraw();
    }
    if (arrowOn) {
      drawArrow();
    }
  }
}
class editInt {
  int val;
  editInt(int v) {
    val=v;
  }
}
