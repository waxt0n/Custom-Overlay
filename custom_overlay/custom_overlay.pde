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

Button leftButton;
Button rightButton;
Button screenButton;

PImage img;//image to show
int counter=0;//which image to show

int screen=1;

void settings() { 
  size(300, 400);
}
void setup()
{
  images=loadImages(dataPath("")); //load images from the data folder into an ArrayList of images
  overlayWindow=new OverlayWindow();

  leftButton = new Button(width*.1, height*.5, width/10, width/10);
  leftButton.arrowOn = true;
  leftButton.arrowDir = 0;

  rightButton = new Button(width*.8, height*.5, width/10, width/10);
  rightButton.arrowOn = true;
  rightButton.arrowDir = 2;

  screenButton = new Button(width*.5, height*.7, width/4, width/10);
  screenButton.text="disp";
}

void draw()
{
  background(155);
  leftButton.display();
  rightButton.display();
  if (rightButton.click||frameCount==1) {
    //loop through images
    counter++;
    if (counter>=images.size()) {
      counter=0;
    }

    if (images.size()>0) {//avoid out of range exception
      img=images.get(counter);//set img, the PImage variable that gets displayed
    }
  }
  if (leftButton.click) {
    counter--;
    if (counter<0) {
      counter=images.size()-1;
    }
    if (images.size()>0) {//avoid out of range exception
      img=images.get(counter);//set img, the PImage variable that gets displayed
    }
  }

  screenButton.display();

  GraphicsEnvironment env = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] devices = env.getScreenDevices();
  int numberofScreens = devices.length;

  if (screenButton.click) {
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
