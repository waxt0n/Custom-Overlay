//Import Libraries
import processing.awt.PSurfaceAWT;
import javax.swing.JPanel;
import javax.swing.JFrame;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

//Declare Gobal Variables
PGraphics pg;
PImage img;
JFrame frame;
JPanel panel;

void setup()
{
  fullScreen(); 
  surface.setAlwaysOnTop(true);

  img = loadImage("teers_aiming_cone.png");
  frame = (JFrame)((PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();

  pg = createGraphics(width, height);

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

void draw()
{
  pg.beginDraw();
  pg.background(0, 0);
  pg.image(img, 0, 0);
  pg.endDraw();
  frame.setBackground(new Color(0, 0, 0, 0));
}
