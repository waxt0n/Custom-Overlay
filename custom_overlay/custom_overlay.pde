//libraries for transparent overlay:
import processing.awt.PSurfaceAWT;
import javax.swing.JPanel;
import javax.swing.JFrame;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

OverlayWindow overlayWindow; 

void setup()
{
  size(300, 400);
  overlayWindow=new OverlayWindow();
}

void draw()
{
}
