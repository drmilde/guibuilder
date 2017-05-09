public class KnobDrawable extends Drawable {


  public KnobDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("knob.png");
    putSProperty("name", "Knob" + IDGen.next());
    putSProperty("tooltip", "Knob" + IDGen.next());
  }

  public KnobDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }

  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"knob\">" + "\n" +  
      "<name label=\"" + pvS("name") + "\">"  + pvS("name") + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\" " +
      "y=\"" + pv("y") + "\" " + 
      "w=\"" + pv("w") + "\" " + 
      "h=\"" + pv("h") + "\">" + 
      "</position>" + "\n" +

      "</widget>"

      );
  }

  public Drawable clone() {
    return new KnobDrawable(
      pv("x"), pv("y"), 
      pv("w"), pv("h"), 
      pv("ux"), pv("uy"), headers);
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
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2) + offRx, 
      pv("y")+ (pv("h")/2) + offRy, 
      pv("w"), pv("h"));
    popStyle();
  }
}

///////////////////////// LABEL

public class LabelDrawable extends Drawable {
  private String text = "none";

  public LabelDrawable(String txt_, int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    text = txt_;
    putSProperty("name", "Label" + IDGen.next());
    putSProperty("text", text);
  }


  public LabelDrawable(String txt_, int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(txt_, x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }


  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"label\">" + "\n" +  
      "<name label=\"" + pvS("text") + "\">"  + pvS("name") + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\" " +
      "y=\"" + pv("y") + "\" " + 
      "w=\"" + pv("w") + "\" " + 
      "h=\"" + pv("h") + "\">" + 
      "</position>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new LabelDrawable(pvS("text"), pv("x"), pv("y"), 
      pv("w"), pv("h"), 
      pv("ux"), pv("uy"), headers);
  }

  public void draw() {
    int offRx = pv("offRx");
    int offRy = pv("offRy");

    super.draw();

    pushStyle();
    stroke(#ffffff);
    fill(#ffffff);
    textAlign(CENTER);
    text(pvS("text"), 
      pv("x") + (pv("w")/2) + offRx, 
      pv("y") + (pv("h")/2) + offRy);
    popStyle();
  }
}

//////////////////// BUTTON
public class ButtonDrawable extends Drawable {

  public ButtonDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("button.png");
    putSProperty("name", "Button" + IDGen.next());
    putSProperty("state1", "bState1");
    putSProperty("state2", "bState2");
    putSProperty("state3", "bState3");
    putSProperty("state4", "bState4");
  }

  public ButtonDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }


  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"button\">" + "\n" +  
      "<name label=\"" + pvS("name") + "\">"  + pvS("name") + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\" " +
      "y=\"" + pv("y") + "\" " + 
      "w=\"" + pv("w") + "\" " + 
      "h=\"" + pv("h") + "\">" + 
      "</position>" + "\n" +

      "<states>" + "\n" +
      "<state>" + pvS("state1") + "</state>" + "\n" +
      "<state>" + pvS("state2") + "</state>" + "\n" +
      "<state>" + pvS("state3") + "</state>" + "\n" +
      "<state>" + pvS("state4") + "</state>" + "\n" +
      "</states>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new ButtonDrawable(pv("x"), pv("y"), 
      pv("w"), pv("h"), 
      pv("ux"), pv("uy"), headers);
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
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2) + offRx, 
      pv("y")+ (pv("h")/2) + offRy, 
      pv("w"), pv("h"));
    popStyle();
  }
}


///////////////////// HSLIDER
public class HSliderDrawable extends Drawable {

  public HSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("hslider.png");
    putSProperty("name", "HSlider" + IDGen.next());
    putFProperty("min", 0);
    putFProperty("max", 1);
  }

  public HSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;  
  }
  
  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"hslider\">" + "\n" +  
      "<name label=\"" + pvS("name") + "\">"  + pvS("name") + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\" " +
      "y=\"" + pv("y") + "\" " + 
      "w=\"" + pv("w") + "\" " + 
      "h=\"" + pv("h") + "\">" + 
      "</position>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new HSliderDrawable(pv("x"), pv("y"), 
      pv("w"), pv("h"), 
      pv("ux"), pv("uy"), headers);
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
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2) + offRx, 
      pv("y") + (pv("h")/2) + offRy, 
      pv("w"), 20);
    popStyle();
  }
}



///////////////////// VSLIDER

public class VSliderDrawable extends Drawable {

  public VSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("vslider.png");
    putSProperty("name", "VSlider" + IDGen.next());
    putFProperty("min", 0);
    putFProperty("max", 1);
  }

  public VSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_, String[] hdrs) {
    this(x_, y_, w_, h_, ux_, uy_);
    headers = hdrs;
  }
  
  
  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"vslider\">" + "\n" +  
      "<name label=\"" + pvS("name") + "\">"  + pvS("name") + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\" " +
      "y=\"" + pv("y") + "\" " + 
      "w=\"" + pv("w") + "\" " + 
      "h=\"" + pv("h") + "\">" + 
      "</position>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new VSliderDrawable(pv("x"), pv("y"), 
      pv("w"), pv("h"), 
      pv("ux"), pv("uy"), headers);
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
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2) + offRx, 
      pv("y") + (pv("h")/2) + offRy, 
      20, pv("h"));
    popStyle();
  }
}