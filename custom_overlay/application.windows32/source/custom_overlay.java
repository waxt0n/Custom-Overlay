import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.awt.PSurfaceAWT; 
import javax.swing.JPanel; 
import javax.swing.JFrame; 
import java.awt.Color; 
import java.awt.Graphics; 
import java.awt.Graphics2D; 
import java.awt.image.BufferedImage; 
import java.awt.GraphicsEnvironment; 
import java.awt.GraphicsDevice; 
import java.awt.HeadlessException; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class custom_overlay extends PApplet {

//libraries for transparent overlay:












String[] images;

OverlayWindow overlayWindow; 

Button imageLeft;
Button imageRight;
Button xLeft;
Button xRight;
Button yLeft;
Button yRight;
Button scaleLeft;
Button scaleRight;
Button alphaLeft;
Button alphaRight;
Button screenButton;
Button startButton;
Button stopButton;

TypeBox fileBox;
TypeBox xOffsetBox;
TypeBox yOffsetBox;
TypeBox scaleBox;
TypeBox alphaBox;

String file = "test";

PImage img;//image to show
int counter=0;//which image to show

int screen=1;
int xOffset=0;
int yOffset=0;
float scale=1;
float alpha = 1;
boolean somethingChanged = false;

int background = 20;
int foreground = 128;
int foregroundActivated = 80;
int textcolor = 255;

public void settings() { 
  size(250, 360);
}
public void setup()
{
  setupSettings();

  shapeMode(CENTER);
  rectMode(CENTER);


  surface.setTitle("Custom Overlay");
  surface.setResizable(false);
  surface.setLocation(100, 100);

  img=loadImage(split(settings[counter], ",")[0]);
  file=split(settings[counter], ",")[0];
  xOffset=PApplet.parseInt(split(settings[counter], ",")[1]);
  yOffset=PApplet.parseInt(split(settings[counter], ",")[2]);
  scale=PApplet.parseFloat(split(settings[counter], ",")[3]);
  alpha=PApplet.parseFloat(split(settings[counter], ",")[4]);

  overlayWindow=new OverlayWindow();

  imageLeft = new Button(37.5f, 52.5f, 25, 25, "<");
  imageRight = new Button(212.5f, 52.5f, 25, 25, ">");

  xLeft = new Button(37.5f, 112.5f, 25, 25, "<");
  xRight = new Button(212.5f, 112.5f, 25, 25, ">");

  yLeft = new Button(37.5f, 172.5f, 25, 25, "<");
  yRight = new Button(212.5f, 172.5f, 25, 25, ">");

  scaleLeft = new Button(37.5f, 232.5f, 25, 25, "<");
  scaleRight = new Button(212.5f, 232.5f, 25, 25, ">");
  
  alphaLeft = new Button(37.5f, 292.5f, 25, 25, "<");
  alphaRight = new Button(212.5f, 292.5f, 25, 25, ">");

  screenButton = new Button(187.5f, 22.5f, 62.5f, 16.5f, "display 1");
  screenButton.textSize=10;
  screenButton.textOffset=1;
  screenButton.radius=2;

  startButton = new Button(181.25f, 333.75f, 100, 25, "Start");
  startButton.textSize=20;
  startButton.textOffset=3;
  stopButton = new Button(68.75f, 333.75f, 100, 25, "Stop");
  stopButton.textSize=20;
  stopButton.textOffset=3;

  fileBox = new TypeBox(PApplet.parseInt(125), PApplet.parseInt(52.5f), 125, 25);
  xOffsetBox = new TypeBox(PApplet.parseInt(125), PApplet.parseInt(112.5f), 125, 25);
  yOffsetBox = new TypeBox(PApplet.parseInt(125), PApplet.parseInt(172.5f), 125, 25);
  scaleBox = new TypeBox(PApplet.parseInt(125), PApplet.parseInt(232.5f), 125, 25);
  alphaBox = new TypeBox(PApplet.parseInt(125), PApplet.parseInt(292.5f), 125, 25);
}

public void draw()
{
  background(background);
  imageLeft.display();
  imageRight.display();
  xLeft.display();
  xRight.display();
  yLeft.display();
  yRight.display();
  scaleLeft.display();
  scaleRight.display();
  alphaLeft.display();
  alphaRight.display();
  startButton.display();
  stopButton.display();
  file=fileBox.run(file);
  if (!file.equals(split(settings[counter], ",")[0]) && somethingChanged == true) {
    String temp1 = file+".png";
    String temp2 = file+".jpg";
    String temp3 = file+".gif";
    for (int i = 0; i < settings.length; i++) {
      if (file.equals(split(settings[i], ",")[0]) || temp1.equals(split(settings[i], ",")[0]) || temp2.equals(split(settings[i], ",")[0]) || temp3.equals(split(settings[i], ",")[0])) {
        counter = i;
        img=loadImage(split(settings[counter], ",")[0]);
        file=split(settings[counter], ",")[0];
        xOffset=PApplet.parseInt(split(settings[counter], ",")[1]);
        yOffset=PApplet.parseInt(split(settings[counter], ",")[2]);
        scale=PApplet.parseFloat(split(settings[counter], ",")[3]);
        alpha=PApplet.parseFloat(split(settings[counter], ",")[4]);
      }
    }
  }
  xOffset=xOffsetBox.run(xOffset);
  yOffset=yOffsetBox.run(yOffset);
  scale=scaleBox.run(scale);
  alpha=constrain(alphaBox.run(alpha),0,1);
  textSize(20);
  text("file:", 25, 30);
  text("X offset:", 25, 90);
  text("Y offset:", 25, 150);
  text("Scale:", 25, 210);
  text("Opacity:", 25, 270);

  if (imageRight.click) {
    //loop through images
    settings[counter] = split(settings[counter], ",")[0]+","+str(xOffset)+","+str(yOffset)+","+nf(scale, 0, 3)+","+nf(alpha, 0, 3);
    updateSettings();
    counter++;
    if (counter>=settings.length) {
      counter=0;
    }
    if (settings.length>0) {//avoid out of range exception
      img=loadImage(split(settings[counter], ",")[0]);//set img, the PImage variable that gets displayed
    }
    file=split(settings[counter], ",")[0];
    xOffset=PApplet.parseInt(split(settings[counter], ",")[1]);
    yOffset=PApplet.parseInt(split(settings[counter], ",")[2]);
    scale=PApplet.parseFloat(split(settings[counter], ",")[3]);
    alpha=PApplet.parseFloat(split(settings[counter], ",")[4]);
  }
  if (imageLeft.click) {//loop through images backwards
    settings[counter] = split(settings[counter], ",")[0]+","+str(xOffset)+","+str(yOffset)+","+nf(scale, 0, 3)+","+nf(alpha, 0, 3);
    updateSettings();
    counter--;
    if (counter<0) {
      counter=settings.length-1;
    }
    if (settings.length>0) {//avoid out of range exception
      img=loadImage(split(settings[counter], ",")[0]);//set img, the PImage variable that gets displayed
    }
    file=split(settings[counter], ",")[0];
    xOffset=PApplet.parseInt(split(settings[counter], ",")[1]);
    yOffset=PApplet.parseInt(split(settings[counter], ",")[2]);
    scale=PApplet.parseFloat(split(settings[counter], ",")[3]);
    alpha=PApplet.parseFloat(split(settings[counter], ",")[4]);
  }

  if (xLeft.clickRepeat) {
    xOffset--;
    somethingChanged = true;
  }
  if (xRight.clickRepeat) {
    xOffset++;
    somethingChanged = true;
  }

  if (yLeft.clickRepeat) {
    yOffset--;
    somethingChanged = true;
  }
  if (yRight.clickRepeat) {
    yOffset++;
    somethingChanged = true;
  }

  if (scaleLeft.clickRepeat) {
    scale = PApplet.parseFloat(nf(scale-0.01f, 0, 3));
    somethingChanged = true;
  }
  if (scaleRight.clickRepeat) {
    scale = PApplet.parseFloat(nf(scale+0.01f, 0, 3));
    somethingChanged = true;
  }
  if (alphaLeft.clickRepeat) {
    alpha = PApplet.parseFloat(nf(constrain(alpha-0.005f,0,1), 0, 3));
    somethingChanged = true;
  }
  if (alphaRight.clickRepeat) {
    alpha = PApplet.parseFloat(nf(constrain(alpha+0.005f,0,1), 0, 3));
    somethingChanged = true;
  }
  if (startButton.click) {
    if (overlayWindow == null) {
      overlayWindow=new OverlayWindow();
    }
  }
  if (stopButton.click) {
    if (overlayWindow !=null) {
      overlayWindow.close();
      overlayWindow = null;
    }
  }

  screenButton.display();

  GraphicsEnvironment env = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] devices = env.getScreenDevices();
  int numberofScreens = devices.length;           //get number of screens

  if (screenButton.click) { //loop through screens
    screen++;
    if (screen>numberofScreens) {
      screen=1;
    }
    screenButton.text="display "+screen;
    if (overlayWindow !=null) {
      overlayWindow.close();
      overlayWindow=new OverlayWindow();
    }
  }

  if (somethingChanged && frameCount%60 == 0) {
    somethingChanged = false;
    settings[counter] = split(settings[counter], ",")[0]+","+str(xOffset)+","+str(yOffset)+","+nf(scale, 0, 3)+","+nf(alpha, 0, 3);
    saveStrings("data\\settings.txt", settings);
  }
}

public ArrayList<PImage> loadImages(String folderPath) {
  ArrayList<PImage> imgs = new ArrayList<PImage>();
  String[] filenames = listImageNames(folderPath);
  if (filenames!=null) {
    for (String fileName : filenames) {
      PImage tempImage = loadImage(folderPath + "/" + fileName);
      if (tempImage!=null) {
        imgs.add(tempImage);
      }
    }
  }
  return imgs;
}

public String[] listImageNames(String dir) {
  File file = new File(dir);

  if (!file.isDirectory()) {
    return null;
  }
  String[] temp = file.list();
  String names[]={};
  for (int i = 0; i != temp.length; i++) {
    String ext = temp[i].substring(temp[i].length()-3, temp[i].length());
    if (ext.equals("png") || ext.equals("jpg") || ext.equals("gif")) {
      names = append(names, temp[i]); // add temp[i] to end of names
    }
  }
  return names;
}
class Button {
  float X;
  float Y;
  float buttonWidth;
  float buttonHeight;
  float borderWeight = 10;
  int primaryColor = foreground;
  int textColor = textcolor;
  float textSize = 30;
  String text = "";
  PFont font;
  boolean enabled = true;
  boolean pressed = false;
  boolean wasPressed = false;
  boolean click = false;
  float clickX;
  float clickY;
  boolean mouseWasPressed = false;
  boolean visible = true;
  boolean borderOn = true;
  int pressedColor = foregroundActivated;
  int hoveredColor = foregroundActivated+20;
  PGraphics drawTo;
  editInt offsetX;
  editInt offsetY;
  boolean useG=false;
  boolean clickRepeat=false;
  long millisClicked=0;
  int timeToRepeat=250;
  int radius=5;
  int textOffset=0;

  Button(float _X, float _Y, float _buttonWidth, float _buttonHeight, String _text) {
    X = _X;
    Y = _Y;
    text=_text;
    buttonWidth = _buttonWidth;
    buttonHeight = _buttonHeight;
    font = createFont("Lucida Sans Regular", textSize);
    drawTo=g;
    useG=true;
    offsetX=new editInt(PApplet.parseInt(-buttonWidth/2));
    offsetY=new editInt(PApplet.parseInt(-buttonHeight/2));
  }
  Button(float _X, float _Y, float _buttonWidth, float _buttonHeight, String _text, PGraphics _drawTo, editInt _offsetX, editInt _offsetY) {
    this(_X, _Y, _buttonWidth, _buttonHeight, _text);
    drawTo=_drawTo;
    text=_text;
    offsetX=_offsetX;
    offsetY=_offsetY;   
    useG=false;
  }
  public void detectClick() {
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

    if (wasPressed && !pressed) {
      if (!mousePressed && (mouseX-offsetX.val) >= X && (mouseX-offsetX.val) <= X + buttonWidth && (mouseY-offsetY.val) >= Y && (mouseY-offsetY.val) <= Y + buttonHeight) {
        click = true;
      }
    }
    if (pressed&&!wasPressed) {
      millisClicked=millis();
    }

    clickRepeat=(!wasPressed&&pressed)||(pressed&&millis()-millisClicked>timeToRepeat);

    wasPressed = pressed;
    mouseWasPressed = mousePressed;
  }

  public void drawText() {
    drawTo.pushStyle();
    drawTo.textAlign(CENTER, CENTER);
    drawTo.textFont(font);
    drawTo.textSize(textSize);
    drawTo.fill(textColor);
    drawTo.text(text, X, Y-buttonHeight*0.25f+textOffset);
    drawTo.popStyle();
  }

  public void display() {
    if (enabled) {
      detectClick();
    }
    if (!useG) {
      drawTo.beginDraw();
    }
    drawTo.pushStyle();
    drawTo.rectMode(CENTER);
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
    drawTo.noStroke();
    drawTo.rect(X, Y, buttonWidth, buttonHeight, radius, radius, radius, radius);
    drawText();
    drawTo.popStyle();
    if (!useG) {
      drawTo.endDraw();
    }
  }
}
class editInt {
  int val;
  editInt(int v) {
    val=v;
  }
}
String[] settings;
PrintWriter output;

public void setupSettings() {

  if (fileExists(dataPath("settings.txt"))) {

    settings = loadStrings("settings.txt");

    updateSettings();
  } else {
    String temp[] = {};
    saveStrings("data\\settings.txt", temp);
    setupSettings();
  }
}

public void updateSettings() {

  images = listImageNames(dataPath(""));
  
  String[] temp = settings;
  String[] temp2 = {};
  settings = temp2;

  for (int i = 0; i < images.length; i++) {
    boolean hasIt = false;
    int position = 0;
    for (int j = 0; j < temp.length; j++) {
      if (split(temp[j], ",")[0].equals(images[i])) {
        hasIt = true;
        position = j;
      }
    }
    if (hasIt) {
      switch(split(temp[position],",").length) {
        case 1:
          temp[position] = temp[position] + ",0,0,1.000,1.000";
        case 2:
          temp[position] = temp[position] + ",0,1.000,1.000";
        case 3:
          temp[position] = temp[position] + ",1.000,1.000";
        case 4:
          temp[position] = temp[position] + ",1.000";
      }
      settings = append(settings, temp[position]);
    } else {
      settings = append(settings, images[i]+",0,0,1.000,1.000");
    }
  }

  settings = sort(settings);
  saveStrings("data\\settings.txt", settings);
}

public boolean fileExists(String path) {
  File file=new File(path);
  boolean exists = file.exists();
  if (exists) {
    return true;
  } else {
    return false;
  }
}
boolean keyPressTypeBox=false;
class TypeBox {
  boolean typeBoxActive=false;
  float x;
  float y;
  float w;
  float h;
  boolean e;
  boolean le;
  String entry="";
  TypeBox(int _x, int _y, float _w, float _h) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    e=false;
    le=false;
  }
  public void doCommon(int numMode) {
    pushStyle();
    le=e;
    if (mousePressed&&mInC(x, y, w, h)&&!typeBoxActive) {
      e=true;
      typeBoxActive=true;
    }
    if (mousePressed&&!mInC(x, y, w, h)&&typeBoxActive) {
      e=false;
      typeBoxActive=false;
      keyPressTypeBox=false;
    }
    if (keyPressTypeBox&&e) {
      if (key==ENTER||key==RETURN||keyCode==66) {
        e=false;
        typeBoxActive=false;
        keyPressTypeBox=false;
      }
      if (key==DELETE) {
        e=false;
        entry="";
        typeBoxActive=false;
        keyPressTypeBox=false;
      }
    }
    textSize(h*.75f);
    if (e) {
      if (keyPressTypeBox&&textWidth(entry)<w-h*.75f) {
        if (numMode==0&&(((key>=32&&key<=126)) && (key != CODED))) {        
          keyPressTypeBox=false;
          entry+=key; //letters and numbers
        }
        if (numMode==1&&((key==45||(key>=48&&key<=57)) && (key != CODED))) {        
          keyPressTypeBox=false;
          entry+=key;//numbers and negative
        }
        if (numMode==2&&((key==45||key==46||(key>=48&&key<=57)) && (key != CODED))) {        
          keyPressTypeBox=false;
          entry+=key;//numbers, negative, and decimal
        }
      }
      if (keyPressTypeBox&&(key==BACKSPACE||keyCode==67)&&entry.length()>0) {        
        keyPressTypeBox=false;
        entry=entry.substring(0, entry.length()-1);
        if (entry.length()==0) {
          entry="";
        }
      }
    }
    if (e)fill(foregroundActivated);//fill clicked
    else if (mInC(x, y, w, h)) fill(foregroundActivated+20); //fill hovered
    else fill(foreground); //fill normal
    rect(x, y, w, h, 5, 5, 5, 5);
    if (e)fill(textcolor);//text clicked
    else fill(textcolor);//text normal
    if (e) {
      text(entry, x+5, y, w, h);
    }
  }
  public String run(String val) {
    if (e&&!le) {
      entry=val;
    }
    doCommon(0);
    if (!e&&le) {//edit finished
      if (entry!="") {
        val=entry;
        somethingChanged = true;
      }
    }
    if (!e) {
      text(val, x+5, y, w, h);
    }
    popStyle();
    return val;
  }
  public int run(int val) {
    if (e&&!le) {
      entry=str(val);
    }
    doCommon(1);
    if (!e&&le) {//edit finished
      if (PApplet.parseInt(entry)==PApplet.parseInt(entry)&&entry!="") {
        val=PApplet.parseInt(entry);
        somethingChanged = true;
      }
    }
    if (!e) {
      text(str(val), x+5, y, w, h);
    }
    popStyle();
    return val;
  }
  public float run(float val) {
    if (e&&!le) {
      entry=str(val);
    }
    doCommon(2);
    if (!e&&le) {//edit finished
      if (PApplet.parseFloat(entry)==PApplet.parseFloat(entry)&&entry!="") {//NaN check
        val=PApplet.parseFloat(entry);
        somethingChanged = true;
      }
    }
    if (!e) {
      text(str(val), x+5, y, w, h);
    }
    popStyle();
    return val;
  }
}
public void keyPressed() {
  keyPressTypeBox=true;
}

public boolean mInC(float x, float y, float w, float h) { //is mouse within bounds, using CENTER shape mode
  if (mouseX>x-w/2&&mouseX<x+w/2&&mouseY>y-h/2&&mouseY<y+h/2) {
    return true;
  }
  return false;
}
class OverlayWindow extends PApplet {
  OverlayWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  PGraphics pg;
  JFrame frame;
  JPanel panel;
  public void settings() {
    fullScreen(screen); //which monitor
  }
  public void setup() {
    pg = createGraphics(width, height);

    surface.setAlwaysOnTop(true);

    frame = (JFrame)((PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
    frame.setBackground(new Color(0, 0, 0, 0));
    JPanel panel = new JPanel() {
      @Override
        protected void paintComponent(Graphics graphics) {
        if (graphics instanceof Graphics2D) {
          Graphics2D g2d = (Graphics2D) graphics;
          g2d.drawImage(pg.image, 0, 0, null);
        }
      }
    };
    frame.setContentPane(panel);
  }
  public void draw() {
    pg.beginDraw();
    pg.background(0, 0);
    if (img!=null) {
      pg.tint(255);//second term is opacity
      pg.imageMode(CENTER);
      pg.tint(255,alpha*255);
      pg.image(img, width/2+xOffset, height/2-yOffset, img.width*scale, img.height*scale);
      pg.noTint();
    }
    pg.endDraw();
    frame.setBackground(new Color(0, 0, 0, 0));
  }
  public void close() {
    noLoop();
    frame.setVisible(false);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "custom_overlay" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
