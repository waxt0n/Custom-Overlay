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
Button screenButton;

typeBox Test;

PImage img;//image to show
int counter=0;//which image to show

int screen=1;
int xOffset=0;
int yOffset=0;
float scale=1;

color background = 20;
color foreground = 128;
color textcolor = 255;

void settings() { 
  size(250, 300);
}
void setup()
{
  setupSettings();

  shapeMode(CENTER);

  
  surface.setTitle("Custom Overlay");
  surface.setResizable(false);
  surface.setLocation(100, 100);
  
  img=loadImage(split(settings[counter],",")[0]);
  xOffset=int(split(settings[counter],",")[1]);
  yOffset=int(split(settings[counter],",")[2]);
  scale=float(split(settings[counter],",")[3]);

  overlayWindow=new OverlayWindow();

  imageLeft = new Button(width*.1, height*.2, width/10, width/10, "<");
  imageRight = new Button(width*.8, height*.2, width/10, width/10, ">");

  xLeft = new Button(width*.1, height*.4, width/10, width/10, "<");
  xRight = new Button(width*.8, height*.4, width/10, width/10, ">");

  yLeft = new Button(width*.1, height*.6, width/10, width/10, "<");
  yRight = new Button(width*.8, height*.6, width/10, width/10, ">");

  scaleLeft = new Button(width*.1, height*.8, width/10, width/10, "<");
  scaleRight = new Button(width*.8, height*.8, width/10, width/10, ">");

  screenButton = new Button(width*.5, height*.05, width/3, width/20, "display 1");
  screenButton.textSize=10;
  screenButton.radius=0;

  Test = new typeBox(width/2, height/2, 60, 30);
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
  Test.run("test");
  textSize(20);
  text("file:", width*.075, height*.175);
  text("X offset:", width*.075, height*.375);
  text("Y offset:", width*.075, height*.575);
  text("Scale:", width*.075, height*.775);

  if (imageRight.click) {
    //loop through images
    settings[counter] = split(settings[counter],",")[0]+","+str(xOffset)+","+str(yOffset)+","+nf(scale,0,2);
    updateSettings();
    counter++;
    if (counter>=settings.length) {
      counter=0;
    }
    if (settings.length>0) {//avoid out of range exception
      img=loadImage(split(settings[counter],",")[0]);//set img, the PImage variable that gets displayed
    }
    xOffset=int(split(settings[counter],",")[1]);
    yOffset=int(split(settings[counter],",")[2]);
    scale=float(split(settings[counter],",")[3]);
  }
  if (imageLeft.click) {//loop through images backwards
    settings[counter] = split(settings[counter],",")[0]+","+str(xOffset)+","+str(yOffset)+","+str(scale);
    updateSettings();
    counter--;
    if (counter<0) {
      counter=settings.length-1;
    }
    if (settings.length>0) {//avoid out of range exception
      img=loadImage(split(settings[counter],",")[0]);//set img, the PImage variable that gets displayed
    }
    xOffset=int(split(settings[counter],",")[1]);
    yOffset=int(split(settings[counter],",")[2]);
    scale=float(split(settings[counter],",")[3]);
  }

  if (xLeft.clickRepeat) {
    xOffset--;
  }
  if (xRight.clickRepeat) {
    xOffset++;
  }

  if (yLeft.clickRepeat) {
    yOffset--;
  }
  if (yRight.clickRepeat) {
    yOffset++;
  }

  if (scaleLeft.clickRepeat) {
    scale-=0.01;
  }
  if (scaleRight.clickRepeat) {
    scale+=0.01;
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
    overlayWindow.close();
    overlayWindow=new OverlayWindow();
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
