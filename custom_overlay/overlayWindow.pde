class OverlayWindow extends PApplet {
  OverlayWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  PGraphics pg;
  PImage img;
  JFrame frame;
  JPanel panel;

  void settings() {
    fullScreen(1); //which monitor
  }
  void setup() {  
    surface.setAlwaysOnTop(true);

   // img = loadImage("teers_aiming_cone.png");
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
  void draw() {
    pg.beginDraw();
    pg.background(0, 0);
    pg.ellipse(50,50,50,50);
    //pg.image(img, 0, 0);
    pg.endDraw();
    frame.setBackground(new Color(0, 0, 0, 0));
  }
}
