public abstract class Drawable implements IDrawable, ISelectable {
  protected PropertyManager pm = new PropertyManager();

  protected String name = "noName";

  protected boolean selected = false;

  //protected int x, y;
  //protected int w, h;
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
    // create properties
    pm.put("x", new Property ("x", 0));
    pm.put("y", new Property ("y", 0));
    pm.put("w", new Property ("w", 0));
    pm.put("h", new Property ("h", 0));

    // set inital values
    ux = ux_;
    uy = uy_;
    set(x_, y_, w_, h_);
  }

  private void set(int px, int py, int w_, int h_) {
    //x = px + ux;
    //y = py + uy;
    //w = w_;
    //h = h_;

    putProperty("x", px + ux);
    putProperty("y", py + uy);
    putProperty("w", w_);
    putProperty("h", h_);
  }

  protected void putProperty(String att, int val) {
    Property prop = pm.get(att);
    if (prop != null) {
      prop.setIValue(val);
      pm.put(att, prop);
    }
  }

  protected int pv(String att) {
    Property prop = pm.get(att);
    if (prop != null) {
      return prop.getIValue();
    }
    return 0;
  }

  //////////

  public void updateAbsolutePos(int gs) {
    int x = pv("x");
    int y = pv("y");

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

    // store current value
    putProperty("x", x);
    putProperty("y", y);
  }

  public void setAbsolutePos(int px, int py, int gs) { // sets absolute pos (snap to gridsize gs)
    putProperty("x", px);
    putProperty("y", py);
       
    updateAbsolutePos(gs);
  }

  public void setRelativePos (int rx_, int ry_, int gs) {
    rx = rx_;
    ry = ry_;

    rx = rx - (rx % gs);
    ry = ry - (ry % gs);
  }

  public void increaseWidth(int inc, int gs) {
    int w = pv("w");
    w += inc;
    if (gs > 0) {
      w = w - (w % gs);
    }
    putProperty("w", w);
  }

  // ISelectable
  public boolean isOver(int px, int py) {

    return( (px > pv("x")) && 
      (px < (pv("x")+pv("w"))) && 
      (py > pv("y")) && 
      (py < (pv("y") + pv("h"))) );
  }

  public boolean inBox(int bx, int by, int bwidth, int bheight) {
    // upper left coord
    boolean p1x = ( (bx < pv("x")) && ((bx + bwidth) > pv("x")) );
    boolean p1y = ( (by < pv("y")) && ((by + bheight) > pv("y")) );

    // lower right coord
    int x2 = pv("x") + pv("w");
    int y2 = pv("y") + pv("h");

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
      rect(pv("x")+rx, pv("y")+ry, pv("w"), pv("h")); // draw including relative offset
    }


    popStyle();
  }



  // getter
  public String getName() {
    return name;
  }
  public int getAbsoluteX() {
    return pv("x") + rx;
  }
  public int getAbsoluteY() {
    return pv("y") + ry;
  }
  public int getWidth() {
    return pv("w");
  }
  public int getHeight() {
    return pv("h");
  }
}