public abstract class Drawable implements IDrawable, ISelectable {
  protected PropertyManager pm = new PropertyManager();

  //protected String name = "noName";  
  protected boolean selected = false;
  protected PImage img = null;

  abstract String toXML();
  abstract Drawable clone();


  ////////////////////////////////////////////

  public Drawable() {
    this(100, 100, 64, 64, 0, 0);
  }

  public Drawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    // create properties
    pm.put("name", new Property ("name", "noName"));

    pm.put("x", new Property ("x", 0));
    pm.put("y", new Property ("y", 0));
    pm.put("w", new Property ("w", 0));
    pm.put("h", new Property ("h", 0));

    pm.put("ux", new Property ("ux", 0));
    pm.put("uy", new Property ("uy", 0));

    pm.put("offRx", new Property ("offRx", 0));
    pm.put("offRy", new Property ("offRy", 0));

    // set inital values
    putIProperty("ux", ux_);
    putIProperty("uy", uy_);

    putIProperty("x", x_ + pv("ux"));
    putIProperty("y", y_ + pv("uy"));
    putIProperty("w", w_);
    putIProperty("h", h_);
  }

  protected void putIProperty(String att, int val) {
    Property prop = pm.get(att);
    if (prop != null) {
      prop.setIValue(val);
      pm.put(att, prop);
    } else {
      // create property
      pm.put(att, new Property (att, val));
    }
  }

  protected void putFProperty(String att, float val) {
    Property prop = pm.get(att);
    if (prop != null) {
      prop.setFValue(val);
      pm.put(att, prop);
    } else {
      // create property
      pm.put(att, new Property (att, val));
    }
  }

  protected void putSProperty(String att, String val) {
    Property prop = pm.get(att);
    if (prop != null) {
      prop.setSValue(val);
      pm.put(att, prop);
    } else {
      // create property
      pm.put(att, new Property (att, val));
    }
  }

  public Property getProperty(String att) {
    return pm.get(att);
  }

  protected int pv(String att) {
    Property prop = pm.get(att);
    if (prop != null) {
      return prop.getIValue();
    }
    return 0;
  }

  protected float pvF(String att) {
    Property prop = pm.get(att);
    if (prop != null) {
      return prop.getFValue();
    }
    return 0;
  }
  
  protected String pvS(String att) {
    Property prop = pm.get(att);
    if (prop != null) {
      return prop.getSValue();
    }
    return "";
  }

  //////////

  public void updateAbsolutePos(int gs) {
    int x = pv("x");
    int y = pv("y");

    x = x + pv("offRx");
    y = y + pv("offRy");

    if (gs > 0) {
      x = x - (x % gs);
      y = y - (y % gs);
    }

    x = max(x, pv("ux")); // do not cross upper border
    y = max(y, pv("uy")); // do not cross left border

    // reset relative offset
    putIProperty("offRx", 0);
    putIProperty("offRy", 0);

    // store current value
    putIProperty("x", x);
    putIProperty("y", y);
  }

  public void setAbsolutePos(int px, int py, int gs) { // sets absolute pos (snap to gridsize gs)
    putIProperty("x", px);
    putIProperty("y", py);

    updateAbsolutePos(gs);
  }

  public void setRelativePos (int rx_, int ry_, int gs) {
    int offRx = pv("offRx");
    int offRy = pv("offRy");

    offRx = rx_;
    offRy = ry_;

    offRx = offRx - (offRx % gs);
    offRy = offRy - (offRy % gs);

    putIProperty("offRx", offRx);
    putIProperty("offRy", offRy);
  }

  public void increaseWidth(int inc, int gs) {
    int w = pv("w");
    w += inc;
    if (gs > 0) {
      w = w - (w % gs);
    }
    putIProperty("w", w);
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
    int offRx = pv("offRx");
    int offRy = pv("offRy");

    pushStyle();
    stroke(#000000);
    noFill();

    // rot, wenn selected
    if (isSelected()) {
      stroke(#ff0000);
      strokeWeight(3);
      rect(pv("x")+offRx, 
        pv("y")+offRy, 
        pv("w"), pv("h")); // draw including relative offset
    }

    popStyle();
  }

  // getter
  public String getName() {
    return pvS("name");
  }
  public int getAbsoluteX() {
    return pv("x") + pv("offRx");
  }
  public int getAbsoluteY() {
    return pv("y") + pv("offRy");
  }
  public int getWidth() {
    return pv("w");
  }
  public int getHeight() {
    return pv("h");
  }
  public String getState(String sname) {
    return pvS(sname);
  }
  public float getMinRange() {
    return pvF("min");
  }
  public float getMaxRange() {
    return pvF("max");
  }

  public String getLabelText() {
    return pvS("text");
  }

}