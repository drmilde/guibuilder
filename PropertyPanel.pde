public class LabelTextPair {
  public GLabel label;
  public GTextField text;

  public LabelTextPair (PApplet parent, int x, int y, int w, int h, String t) {
    label = new GLabel(parent, x, y + 0, w, h);
    label.setText(t, GAlign.LEFT, GAlign.MIDDLE);
    label.setOpaque(true);
    label.setTextBold();

    text = new GTextField(parent, x, y + h, w, h);
    text.tag = t + " tf";
  }
}


public class PropertyPanel {
  private PApplet parent = null;
  private ArrayList<LabelTextPair> elements = new ArrayList<LabelTextPair>();
  public Rectangle border;
  public GLabel title;

  private int maxEntries = 10;
  private int x, y, w, h;

  public PropertyPanel(PApplet p, int x, int y, int w, int h, String t) {
    parent = p;
    initPanel(x, y, w, h, t);
  }

  private void initPanel(int x_, int y_, int w_, int h_, String t_) {
    x = x_; 
    y = y_; 
    w = w_; 
    h = h_; 

    title = new GLabel(parent, x, y + 0, w, h);
    title.setText(t_, GAlign.LEFT, GAlign.MIDDLE);
    title.setOpaque(true);
    title.setTextBold();

    elements.clear();
    for (int i = 0; i < maxEntries; i++) {
      LabelTextPair pair = new LabelTextPair(parent, x, y + 30 + i * (2*h), w, h, (t_ + "_" + i));
      elements.add(pair);
    }
    border = new Rectangle(x-4, y-4, w+8, (h*2*maxEntries + 30) + 16);
  }


  public void show(boolean show) {
    title.setVisible(show);

    int idx = 0;
    for (LabelTextPair pair : elements) {
      if (idx < maxEntries) {
        pair.label.setVisible(show);
        pair.text.setVisible(show);
      } else {
        pair.label.setVisible(false);
        pair.text.setVisible(false);
      }
      idx++;
    }

    if (show) {
      showFrame();
    }
  }

  public void setHeaders(String[] headers) {
    int idx = 0;
    for (LabelTextPair pair : elements) {
      if (idx < headers.length) {
        pair.label.setText(headers[idx], GAlign.LEFT, GAlign.MIDDLE);
        pair.label.setOpaque(true);
        pair.label.setTextBold();
        pair.text.tag = headers[idx] + "_" +  idx + " tf";
      }
      idx++;
    }
    maxEntries = headers.length;
    border = new Rectangle(x-4, y-4, w+8, (h*2*maxEntries + 30) + 16);
  }

  // Simple graphical frame to group controls
  public void showFrame() {
    pushStyle();
    noFill();
    strokeWeight(2);
    stroke(color(240, 240, 255));
    rect(border.x, border.y, border.width, border.height);
    popStyle();
  }


  public boolean hasFocus() {
    boolean r = false;

    int idx = 0;
    for (LabelTextPair pair : elements) {
      if (idx < maxEntries) {
        r = r || pair.text.hasFocus();
      } 
      idx++;
    }

    return r;
  }


  // update fields of property panel

  public void clearFields() {
    int idx = 0;
    for (LabelTextPair pair : elements) {
      if (idx < maxEntries) {
        pair.text.setText("");
      } 
      idx++;
    }
  }

  private void setField(String n, String v) {
    int idx = 0;
    for (LabelTextPair pair : elements) {
      if (idx < maxEntries) {
        if (pair.label.getText() == n) {
          pair.text.setText(v);
        }
      } 
      idx++;
    }
  }

  public void setFields(Drawable d) {
    if (d != null) {

      // name, position and dimensions
      setField("Name", (d.getName()));
      setField("x", d.getAbsoluteX() + "");
      setField("y", (d.getAbsoluteY() + ""));
      setField("width", (d.getWidth() + ""));
      setField("height", (d.getHeight() + ""));

      // min max of slider
      setField("min", (d.getMinRange() + ""));
      setField("max", (d.getMaxRange() + ""));

      // possible state of a button, default is four 
      setField("state 1", (d.getState("state1") + ""));
      setField("state 2", (d.getState("state2") + ""));
      setField("state 3", (d.getState("state3") + ""));
      setField("state 4", (d.getState("state4") + ""));

      // label text
      setField("Text", (d.getLabelText() + ""));
    }
  }
}