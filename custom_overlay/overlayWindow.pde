class OverlayWindow extends PApplet {
  OverlayWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  PGraphics pg;
  JFrame frame;
  JPanel panel;
  void settings() {
    fullScreen(screen); //which monitor
  }
  void setup() {
    pg = createGraphics(width, height);

    surface.setAlwaysOnTop(true);

    frame = (JFrame)((PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
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
    if (img!=null) {
      pg.tint(255);//second term is opacity
      pg.imageMode(CENTER);
      pg.image(img, width/2+xOffset, height/2+yOffset, img.width*scale, img.height*scale);
      pg.noTint();
    }
    pg.endDraw();
    frame.setBackground(new Color(0, 0, 0, 0));
  }
  void close() {
    frame.setVisible(false);
  }
}
