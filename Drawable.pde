public abstract class Drawable implements IDrawable, ISelectable {
  protected String name = "noName";

  protected boolean selected = false;

  protected int x, y;
  protected int w, h;
  protected int ux, uy;

  protected int rx = 0; // relative x offset
  protected int ry = 0; // relative y offset

  protected PImage img = null;

  abstract String toXML();
  abstract Drawable clone();


  ////////////////////////////////////////////

  public Drawable() {
    this(100, 100, 64, 64, 0, 0);
  }

  public Drawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    ux = ux_;
    uy = uy_;
    set(x_, y_, w_, h_);
  }

  private void set(int px, int py, int w_, int h_) {
    x = px + ux;
    y = py + uy;
    w = w_;
    h = h_;
  }

  public void updateAbsolutePos(int gs) {
    x = x + rx;
    y = y + ry;

    if (gs > 0) {
      x = x - (x % gs);
      y = y - (y % gs);
    }

    x = max(x, ux); // do not cross upper border
    y = max(y, uy); // do not cross left border

    // reset relative offset
    rx = 0;
    ry = 0;
  }

  public void setAbsolutePos(int px, int py, int gs) { // sets absolute pos (snap to gridsize gs)
    x = px;
    y = py;

    updateAbsolutePos(gs);
  }

  public void setRelativePos (int rx_, int ry_, int gs) {
    rx = rx_;
    ry = ry_;

    rx = rx - (rx % gs);
    ry = ry - (ry % gs);
  }

  public void increaseWidth(int inc, int gs) {
    w += inc;
    if (gs > 0) {
      w = w - (w % gs);
    }
  }

  // ISelectable
  public boolean isOver(int px, int py) {
    return( (px > x) && (px < (x+w)) && (py > y) && (py < (y +h)) );
  }

  public boolean inBox(int bx, int by, int bwidth, int bheight) {
    // upper left coord
    boolean p1x = ( (bx < x) && ((bx + bwidth) > x) );
    boolean p1y = ( (by < y) && ((by + bheight) > y) );

    // lower right coord
    int x2 = x + w;
    int y2 = y + h;

    boolean p2x = ( (bx < x2) && ((bx + bwidth) > x2) );
    boolean p2y = ( (by < y2) && ((by + bheight) > y2) );

    return (p1x && p1y && p2x && p2y);
  }

  public boolean isSelected() {
    return selected;
  }

  public void select(boolean v) {
    selected = v;
  }

  // IDrawable
  public void draw() {
    pushStyle();
    stroke(#000000);
    noFill();

    // rot, wenn selected
    if (isSelected()) {
      stroke(#ff0000);
      strokeWeight(3);
      rect(x+rx, y+ry, w, h); // draw including relative offset
    }


    popStyle();
  }
  
  
  
  // getter
  public String getName() {
    return name;
  }
}