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

ArrayList<PImage> images = new ArrayList<PImage>();

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

PImage img;//image to show
int counter=0;//which image to show

int screen=1;
int xOffset=0;
int yOffset=0;
float scale=1;

void settings() { 
  size(250, 300);
}
void setup()
{
  shapeMode(CENTER);
  surface.setTitle("Custom Overlay");
  surface.setResizable(false);
  surface.setLocation(100, 100);

  images=loadImages(dataPath("")); //load images from the data folder into an ArrayList of images
  if (images.size()>0) {//avoid out of range exception
    img=images.get(0);//set img, the PImage variable that gets displayed
  }

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
}

void draw()
{
  background(20);
  imageLeft.display();
  imageRight.display();
  xLeft.display();
  xRight.display();
  yLeft.display();
  yRight.display();
  scaleLeft.display();
  scaleRight.display();
  textSize(20);
  text("file:", width*.075, height*.175);
  text("X offset:", width*.075, height*.375);
  text("Y offset:", width*.075, height*.575);
  text("Scale:", width*.075, height*.775);

  if (imageRight.click) {
    //loop through images
    counter++;
    if (counter>=images.size()) {
      counter=0;
    }
    if (images.size()>0) {//avoid out of range exception
      img=images.get(counter);//set img, the PImage variable that gets displayed
    }
  }
  if (imageLeft.click) {//loop through images backwards
    counter--;
    if (counter<0) {
      counter=images.size()-1;
    }
    if (images.size()>0) {//avoid out of range exception
      img=images.get(counter);//set img, the PImage variable that gets displayed
    }
  }

  if (xLeft.clickRepeat) {
    xOffset--;
  }
  if (xRight.clickRepeat) {
    xOffset++;
  }

  if (yLeft.clickRepeat) {
    yOffset++;
  }
  if (yRight.clickRepeat) {
    yOffset--;
  }

  if (scaleLeft.clickRepeat) {
    scale-=0.05;
  }
  if (scaleRight.clickRepeat) {
    scale+=0.05;
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
    overlayWindow.close();
    overlayWindow=new OverlayWindow();
  }
}

ArrayList<PImage> loadImages(String folderPath) {
  ArrayList<PImage> imgs = new ArrayList<PImage>();
  String[] filenames = listFileNames(folderPath);
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

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  }
  return null;
}
