public abstract class ImageDrawable extends Drawable {
  public ImageDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String fname) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage(fname);
  }

  public String toXML(String insert, String type) {
    return (
      "<widget type=\"" + type + "\">" + "\n" +  
      "<name label=\"" + pvS("Name") + "\">"  + pvS("Name") + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\" " +
      "y=\"" + pv("y") + "\" " + 
      "w=\"" + pv("width") + "\" " + 
      "h=\"" + pv("height") + "\">" + 
      "</position>" + "\n" +

      insert + 

      "</widget>"

      );
  }

  // overwrite draw method
  public void draw() {
    int offRx = pv("offRx");
    int offRy = pv("offRy");

    super.draw();

    pushStyle();
    fill(#444444);
    stroke(#000000);
    strokeWeight(2);

    imageMode(CENTER);
    image(img, pv("x")+(pv("width")/2) + offRx, 
      pv("y")+ (pv("height")/2) + offRy, 
      pv("width"), pv("height"));

    popStyle();
  }
}


public abstract class TextDrawable extends Drawable {

  public TextDrawable(String txt_, int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    putSProperty("Text", txt_);
  }

  // implement abstract methods
  public String toXML(String insert, String type) {
    return (
      "<widget type=\"" + type + "\">" + "\n" + 
      "<name label=\"" + pvS("Text") + "\">"  + pvS("Name") + "</name>" + "\n" +
      "<position " +  
      "x=\"" + pv("x") + "\" " +
      "y=\"" + pv("y") + "\" " + 
      "w=\"" + pv("width") + "\" " + 
      "h=\"" + pv("height") + "\">" + 
      "</position>" + "\n" +

      insert +

      "</widget>"
      );
  }

  public void draw() {
    int offRx = pv("offRx");
    int offRy = pv("offRy");

    super.draw();

    pushStyle();
    stroke(#ffffff);
    fill(#ffffff);
    textAlign(CENTER);
    text(pvS("Text"), 
      pv("x") + (pv("width")/2) + offRx, 
      pv("y") + (pv("height")/2) + offRy);
    popStyle();
  }
}


public class KnobDrawable extends ImageDrawable {

  public KnobDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "knob.png");
    putSProperty("Name", "Knob" + IDGen.next());
    putSProperty("tooltip", "Knob");
  }

  public KnobDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "knob"));
  }

  public Drawable clone() {
    return new KnobDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}

///////////////////////// LABEL
public class LabelDrawable extends TextDrawable {

  public LabelDrawable(String txt_, int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(txt_, x_, y_, w_, h_, ux_, uy_);
    putSProperty("Name", "Label" + IDGen.next());
    putSProperty("tooltip", "Label");
  }

  public LabelDrawable(String txt_, int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(txt_, x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "label"));
  }

  public Drawable clone() {
    return new LabelDrawable(
      pvS("Text"), pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}

//////////////////// BUTTON
public class ButtonDrawable extends ImageDrawable {

  public ButtonDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "button.png");
    putSProperty("Name", "Button" + IDGen.next());
    putSProperty("tooltip", "Button");
    putSProperty("state 1", "bState1");
    putSProperty("state 2", "bState2");
    putSProperty("state 3", "bState3");
    putSProperty("state 4", "bState4");
  }

  public ButtonDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }


  // implement abstract methods
  public String toXML() {
    String insert = 
      "<states>" + "\n" +
      "<state>" + pvS("state 1") + "</state>" + "\n" +
      "<state>" + pvS("state 2") + "</state>" + "\n" +
      "<state>" + pvS("state 3") + "</state>" + "\n" +
      "<state>" + pvS("state 4") + "</state>" + "\n" +
      "</states>" + "\n";

    return (toXML(insert, "button"));
  }

  public Drawable clone() {
    return new ButtonDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}


///////////////////// HSLIDER
public class HSliderDrawable extends ImageDrawable {

  public HSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "hslider.png");
    putSProperty("Name", "HSlider" + IDGen.next());
    putSProperty("tooltip", "HSlider");
    putFProperty("min", 0);
    putFProperty("max", 1);
  }

  public HSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "hslider"));
  }

  public Drawable clone() {
    return new HSliderDrawable(pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }

}



///////////////////// VSLIDER

public class VSliderDrawable extends ImageDrawable {

  public VSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "vslider.png");
    putSProperty("Name", "VSlider" + IDGen.next());
    putSProperty("tooltip", "VSlider");
    putFProperty("min", 0);
    putFProperty("max", 1);
  }

  public VSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "vslider"));
  }

  public Drawable clone() {
    return new VSliderDrawable(pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}


/////////////// Slider2D
public class Slider2DDrawable extends ImageDrawable {

  public Slider2DDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "slider2d.png");
    putSProperty("Name", "slider2D" + IDGen.next());
    putSProperty("tooltip", "Slider2D");
  }

  public Slider2DDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "slider2D"));
  }

  public Drawable clone() {
    return new Slider2DDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}

/////////////// TextField
public class TextFieldDrawable extends ImageDrawable {

  public TextFieldDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "textfield.png");
    putSProperty("Name", "TextField" + IDGen.next());
    putSProperty("tooltip", "Textfield");
  }

  public TextFieldDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "textfield"));
  }

  public Drawable clone() {
    return new TextFieldDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}


/////////////// MultiText
public class MultiTextDrawable extends ImageDrawable {

  public MultiTextDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "multitext.png");
    putSProperty("Name", "MultiText" + IDGen.next());
    putSProperty("tooltip", "Multitext");
  }

  public MultiTextDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "multitext"));
  }

  public Drawable clone() {
    return new MultiTextDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}

/////////////// MultiSlider
public class MultiSliderDrawable extends ImageDrawable {

  public MultiSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "multislider.png");
    putSProperty("Name", "MultiSlider" + IDGen.next());
    putSProperty("tooltip", "Multislider");
  }

  public MultiSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "multislider"));
  }

  public Drawable clone() {
    return new MultiSliderDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}



/////////////// FlowLayout
public class FlowLayoutDrawable extends ImageDrawable {

  public FlowLayoutDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "flowlayout.png");
    putSProperty("Name", "FlowLayout" + IDGen.next());
    putSProperty("tooltip", "FlowLayout");
  }

  public FlowLayoutDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "flowlayout"));
  }

  public Drawable clone() {
    return new FlowLayoutDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}


/////////////// GROUP
public class GroupDrawable extends ImageDrawable {

  public GroupDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "group.png");
    putSProperty("Name", "Group" + IDGen.next());
    putSProperty("tooltip", "Group");
  }

  public GroupDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "group"));
  }

  public Drawable clone() {
    return new GroupDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}



///////////////////// VRANGESLIDER
public class VRangeSliderDrawable extends ImageDrawable {

  public VRangeSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "vrangeslider.png");
    putSProperty("Name", "VRangeSlider" + IDGen.next());
    putSProperty("tooltip", "VRangeSlider");
    putFProperty("min", 0);
    putFProperty("max", 1);
  }

  public VRangeSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "vrangeslider"));
  }

  public Drawable clone() {
    return new VRangeSliderDrawable(pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}


///////////////////// VRANGESLIDER
public class HRangeSliderDrawable extends ImageDrawable {

  public HRangeSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "hrangeslider.png");
    putSProperty("Name", "HRangeSlider" + IDGen.next());
    putSProperty("tooltip", "HRangeSlider");
    putFProperty("min", 0);
    putFProperty("max", 1);
  }

  public HRangeSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "hrangeslider"));
  }

  public Drawable clone() {
    return new HRangeSliderDrawable(pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}


///////////////////// LISTVIEW
public class ListViewDrawable extends ImageDrawable {

  public ListViewDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "listview.png");
    putSProperty("Name", "ListView" + IDGen.next());
    putSProperty("tooltip", "ListView");
    putFProperty("min", 0);
    putFProperty("max", 1);
  }

  public ListViewDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "listview"));
  }

  public Drawable clone() {
    return new ListViewDrawable(pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}

/////////////// GridLayout
public class GridLayoutDrawable extends ImageDrawable {

  public GridLayoutDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_, "gridlayout.png");
    putSProperty("Name", "GridLayout" + IDGen.next());
    putSProperty("tooltip", "GridLayout");
  }

  public GridLayoutDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (toXML("", "gridlayout"));
  }

  public Drawable clone() {
    return new GridLayoutDrawable(
      pv("x"), pv("y"), 
      pv("width"), pv("height"), 
      pv("ux"), pv("uy"), headers);
  }
}