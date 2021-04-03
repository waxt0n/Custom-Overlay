class OverlayWindow extends PApplet {
  OverlayWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  PGraphics pg;
  JFrame frame;
  JPanel panel;
  void settings() {
    println(screen);
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
      pg.tint(255, 100);//second term is opacity
      pg.image(img, 0, 0, width, height);
      pg.noTint();
    }
    pg.endDraw();
    frame.setBackground(new Color(0, 0, 0, 0));
  }
  void close() {
    frame.setVisible(false);
  }
}
