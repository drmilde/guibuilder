public class KnobDrawable extends Drawable {

  public KnobDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("knob.png");
    name = "Knob" + IDGen.next();
  }

  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"knob\">" + "\n" +  
      "<name label=\"" + name + "\">"  + name + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\"" +
      "y=\"" + pv("y") + "\"" + 
      "w=\"" + pv("w") + "\"" + 
      "h=\"" + pv("h") + "\"" + 
      "</position>" + "\n" +

      "</widget>"

      );
  }

  public Drawable clone() {
    return new KnobDrawable(pv("x"), pv("y"), pv("w"), pv("h"), ux, uy);
  }


  // overwrite draw method
  public void draw() {
    super.draw();

    pushStyle();
    fill(#444444);
    stroke(#000000);
    strokeWeight(2);
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2)+rx, pv("y")+ (pv("h")/2)+ry, pv("w"), pv("h"));
    popStyle();
  }
}

///////////////////////// LABEL

public class LabelDrawable extends Drawable {
  private String text = "none";

  public LabelDrawable(String txt_, int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    text = txt_;
    name = "Label" + IDGen.next();
  }

  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"label\">" + "\n" +  
      "<name label=\"" + name + "\">"  + name + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\"" +
      "y=\"" + pv("y") + "\"" + 
      "w=\"" + pv("w") + "\"" + 
      "h=\"" + pv("h") + "\"" + 
      "</position>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new LabelDrawable(text, pv("x"), pv("y"), pv("w"), pv("h"), ux, uy);
  }

  public void draw() {
    super.draw();

    pushStyle();
    stroke(#ffffff);
    fill(#ffffff);
    textAlign(CENTER);
    text(text, pv("x") + (pv("w")/2) + rx, pv("y") + (pv("h")/2)+ ry);
    popStyle();
  }
}

//////////////////// BUTTON


public class ButtonDrawable extends Drawable {

  public ButtonDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("button.png");
    name = "Button" + IDGen.next();
  }

  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"button\">" + "\n" +  
      "<name label=\"" + name + "\">"  + name + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\"" +
      "y=\"" + pv("y") + "\"" + 
      "w=\"" + pv("w") + "\"" + 
      "h=\"" + pv("h") + "\"" + 
      "</position>" + "\n" +

      "<states>" + "\n" +
      "<state>state1</state>" + "\n" +
      "<state>state2</state>" + "\n" +
      "<state>state3</state>" + "\n" +
      "<state>state4</state>" + "\n" +
      "</states>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new ButtonDrawable(pv("x"), pv("y"), pv("w"), pv("h"), ux, uy);
  }


  // overwrite draw method
  public void draw() {
    super.draw();

    pushStyle();
    fill(#444444);
    stroke(#000000);
    strokeWeight(2);
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2) + rx, 
      pv("y")+ (pv("h")/2) + ry, 
      pv("w"), pv("h"));
    popStyle();
  }
}


///////////////////// HSLIDER

public class HSliderDrawable extends Drawable {

  public HSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("hslider.png");
    name = "HSlider" + IDGen.next();
  }

  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"hslider\">" + "\n" +  
      "<name label=\"" + name + "\">"  + name + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\"" +
      "y=\"" + pv("y") + "\"" + 
      "w=\"" + pv("w") + "\"" + 
      "h=\"" + pv("h") + "\"" + 
      "</position>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new HSliderDrawable(pv("x"), pv("y"), pv("w"), pv("h"), ux, uy);
  }


  // overwrite draw method
  public void draw() {
    super.draw();

    pushStyle();
    fill(#444444);
    stroke(#000000);
    strokeWeight(2);
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2) + rx, 
      pv("y") + (pv("h")/2) + ry, 
      pv("w"), 20);
    popStyle();
  }
}



///////////////////// VSLIDER

public class VSliderDrawable extends Drawable {

  public VSliderDrawable(int x_, int y_, int w_, int h_, int ux_, int uy_) {
    super(x_, y_, w_, h_, ux_, uy_);
    img = loadImage("vslider.png");
    name = "VSlider" + IDGen.next();
  }

  // implement abstract methods
  public String toXML() {
    return (
      "<widget type=\"vslider\">" + "\n" +  
      "<name label=\"" + name + "\">"  + name + "</name>" + "\n" +

      "<position " +  
      "x=\"" + pv("x") + "\"" +
      "y=\"" + pv("y") + "\"" + 
      "w=\"" + pv("w") + "\"" + 
      "h=\"" + pv("h") + "\"" + 
      "</position>" + "\n" +

      "</widget>"
      );
  }

  public Drawable clone() {
    return new VSliderDrawable(pv("x"), pv("y"), pv("w"), pv("h"), ux, uy);
  }


  // overwrite draw method
  public void draw() {
    super.draw();

    pushStyle();
    fill(#444444);
    stroke(#000000);
    strokeWeight(2);
    //ellipse(x + w/2, y + h/2, w, h);
    imageMode(CENTER);
    image(img, pv("x")+(pv("w")/2) + rx, 
      pv("y") + (pv("h")/2) + ry, 
      20, pv("h"));
    popStyle();
  }
}