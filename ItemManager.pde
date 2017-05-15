import java.io.ByteArrayOutputStream;
import java.io.*;

public class ItemManager {
  private ArrayList<Drawable> items = new ArrayList<Drawable>();

  public ItemManager() {
    clear();
  }

  public void clear() {
    items.clear();
  }

  public void add(Drawable d) {
    items.add(d);
  }

  public void addAndSelect(Drawable d) {
    unSelectAll();
    d.select(true);
    items.add(d);
  }

  public void unSelectAll() {
    for (Drawable d : items) {
      d.select(false);
    }
  }

  public void selectAll(boolean b) {
    for (Drawable d : items) {
      d.select(b);
    }
  }

  public void select(int x, int y, boolean multi) {
    if (!multi) {
      unSelectAll();
    }
    for (Drawable d : items) {
      if (d.isOver(x, y)) {
        d.select(true);
        return;
      }
    }
  }

  public void boxSelect(int bx, int by, int bwidth, int bheight) {
    unSelectAll();
    for (Drawable d : items) {
      if (d.inBox(bx, by, bwidth, bheight)) {
        d.select(true);
      }
    }
  }

  public Drawable getFirstSelected() {
    for (Drawable d : items) {
      if (d.isSelected()) {
        return d;
      }
    }
    return null;
  }


  public void updateAbsolutePos(int gs) {
    for (Drawable d : items) {
      d.updateAbsolutePos(gs);
    }
  }

  public void setAbsolutePos(int x, int y, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.setAbsolutePos(x, y, gs);
      }
    }
  }

  public void setRelativePos(int rx, int ry, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.setRelativePos(rx, ry, gs);
      }
    }
  }

  public void increaseWidth(int inc, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.increaseWidth(inc, gs);
      }
    }
  }

  public void updateSize(int gs) {
    for (Drawable d : items) {
      d.updateWidth(gs);
      d.updateHeight(gs);
    }
  }


  public void setWidthDelta(int minVal, int delta, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.setWidthDelta(minVal, delta);
      }
    }
  }

  public void increaseHeight(int inc, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.increaseHeight(inc, gs);
      }
    }
  }

  public void setHeightDelta(int minVal, int delta, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.setHeightDelta(minVal, delta);
      }
    }
  }


  public void alignVertical(int gs) {
    Drawable fd = getFirstSelected();
    if (fd != null) {
      int minx = fd.getAbsoluteX();
      for (Drawable d : items) {
        if (d.isSelected()) {
          d.updateAbsolutePos(gs);
          minx = min (d.getAbsoluteX(), minx);
        }
      }

      // update x position
      for (Drawable d : items) {
        if (d.isSelected()) {
          d.setAbsolutePos(minx, d.getAbsoluteY(), gs);
        }
      }
    }
  }

  public void alignHorizontal(int gs) {
    Drawable fd = getFirstSelected();
    if (fd != null) {
      int miny = fd.getAbsoluteY();
      for (Drawable d : items) {
        if (d.isSelected()) {
          d.updateAbsolutePos(gs);
          miny = min (d.getAbsoluteY(), miny);
        }
      }

      // update x position
      for (Drawable d : items) {
        if (d.isSelected()) {
          d.setAbsolutePos(d.getAbsoluteX(), miny, gs);
        }
      }
    }
  }

  // spread horizontal
  public void spreadHorizontal(int incr, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.updateAbsolutePos(gs);
      }
    }

    // update x position
    int fak = 0;
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.setAbsolutePos(d.getAbsoluteX() + (fak * incr), 
          d.getAbsoluteY(), gs);
        fak++;
      }
    }
  }


  // spread vertical
  public void spreadVertical(int incr, int gs) {
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.updateAbsolutePos(gs);
      }
    }

    // update y position
    int fak = 0;
    for (Drawable d : items) {
      if (d.isSelected()) {
        d.setAbsolutePos(
          d.getAbsoluteX(), 
          d.getAbsoluteY() + (fak * incr), 
          gs);
        fak++;
      }
    }
  }




  public void removeSelected() {
    for (int i = items.size() - 1; i >= 0; i--) {
      Drawable d = items.get(i);
      if (d.isSelected()) {
        items.remove(i);
      }
    }
  }

  public Drawable cloneSelected() {
    for (Drawable d : items) {
      if (d.isSelected()) {
        return d.clone();
      }
    }
    return null;
  }

  public void duplicateSelected(int ox, int oy, int gs) {
    ArrayList<Drawable> selItems = new ArrayList<Drawable>();

    for (Drawable d : items) {
      if (d.isSelected()) {
        Drawable cl = d.clone();
        cl.setRelativePos(ox, oy, gs);
        selItems.add(cl);
      }
    }

    // copy and select the duplicated items
    unSelectAll();
    for (Drawable d : selItems) {
      d.select(true);
      d.updateAbsolutePos(gs);
      items.add(d);
    }
  }

  public String getTooltip(int px, int py) {
    for (Drawable d : items) {
      if (d.isOver(px, py)) {
        return d.pvS("tooltip");
      }
    }
    return "";
  }


  public String toXML() {
    IDGen.reset();
    String result = "<gui>" + "\n";

    for (Drawable d : items) {
      result += d.toXML() + "\n";
    }
    return (result + "</gui>");
  }

  private byte[] convertToBytes(Object arr) throws IOException {
    ByteArrayOutputStream bos = new ByteArrayOutputStream();
    ObjectOutput out = new ObjectOutputStream(bos);
    out.writeObject(arr);
    return bos.toByteArray();
  }

  public void save() {
    Object[]arr = items.toArray();
    try {
      byte[] data = convertToBytes(arr);
      saveBytes("numbers.dat", data);
    } 
    catch (Exception ex) {
      println (ex);
    }
  }

  public void draw() {
    for (Drawable d : items) {
      d.draw();
    }
  }
}