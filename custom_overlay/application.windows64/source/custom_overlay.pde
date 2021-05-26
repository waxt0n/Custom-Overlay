//libraries for transparent overlay:
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

color background = 20;
color foreground = 128;
color foregroundActivated = 80;
color textcolor = 255;

void settings() { 
  size(250, 360);
}
void setup()
{
  setupSettings();

  shapeMode(CENTER);
  rectMode(CENTER);


  surface.setTitle("Custom Overlay");
  surface.setResizable(false);
  surface.setLocation(100, 100);

  img=loadImage(split(settings[counter], ",")[0]);
  file=split(settings[counter], ",")[0];
  xOffset=int(split(settings[counter], ",")[1]);
  yOffset=int(split(settings[counter], ",")[2]);
  scale=float(split(settings[counter], ",")[3]);
  alpha=float(split(settings[counter], ",")[4]);

  overlayWindow=new OverlayWindow();

  imageLeft = new Button(37.5, 52.5, 25, 25, "<");
  imageRight = new Button(212.5, 52.5, 25, 25, ">");

  xLeft = new Button(37.5, 112.5, 25, 25, "<");
  xRight = new Button(212.5, 112.5, 25, 25, ">");

  yLeft = new Button(37.5, 172.5, 25, 25, "<");
  yRight = new Button(212.5, 172.5, 25, 25, ">");

  scaleLeft = new Button(37.5, 232.5, 25, 25, "<");
  scaleRight = new Button(212.5, 232.5, 25, 25, ">");
  
  alphaLeft = new Button(37.5, 292.5, 25, 25, "<");
  alphaRight = new Button(212.5, 292.5, 25, 25, ">");

  screenButton = new Button(187.5, 22.5, 62.5, 16.5, "display 1");
  screenButton.textSize=10;
  screenButton.textOffset=1;
  screenButton.radius=2;

  startButton = new Button(181.25, 333.75, 100, 25, "Start");
  startButton.textSize=20;
  startButton.textOffset=3;
  stopButton = new Button(68.75, 333.75, 100, 25, "Stop");
  stopButton.textSize=20;
  stopButton.textOffset=3;

  fileBox = new TypeBox(int(125), int(52.5), 125, 25);
  xOffsetBox = new TypeBox(int(125), int(112.5), 125, 25);
  yOffsetBox = new TypeBox(int(125), int(172.5), 125, 25);
  scaleBox = new TypeBox(int(125), int(232.5), 125, 25);
  alphaBox = new TypeBox(int(125), int(292.5), 125, 25);
}

void draw()
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
        xOffset=int(split(settings[counter], ",")[1]);
        yOffset=int(split(settings[counter], ",")[2]);
        scale=float(split(settings[counter], ",")[3]);
        alpha=float(split(settings[counter], ",")[4]);
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
    xOffset=int(split(settings[counter], ",")[1]);
    yOffset=int(split(settings[counter], ",")[2]);
    scale=float(split(settings[counter], ",")[3]);
    alpha=float(split(settings[counter], ",")[4]);
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
    xOffset=int(split(settings[counter], ",")[1]);
    yOffset=int(split(settings[counter], ",")[2]);
    scale=float(split(settings[counter], ",")[3]);
    alpha=float(split(settings[counter], ",")[4]);
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
    scale = float(nf(scale-0.01, 0, 3));
    somethingChanged = true;
  }
  if (scaleRight.clickRepeat) {
    scale = float(nf(scale+0.01, 0, 3));
    somethingChanged = true;
  }
  if (alphaLeft.clickRepeat) {
    alpha = float(nf(constrain(alpha-0.005,0,1), 0, 3));
    somethingChanged = true;
  }
  if (alphaRight.clickRepeat) {
    alpha = float(nf(constrain(alpha+0.005,0,1), 0, 3));
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

ArrayList<PImage> loadImages(String folderPath) {
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

String[] listImageNames(String dir) {
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
