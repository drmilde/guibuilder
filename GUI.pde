// Controls used for file dialog GUI 
GLabel title;
GButton btnFolder, btnInput, btnOutput;

// property fields
GLabel nameLabel;
GTextField nameTextField;
GLabel xLabel;
GTextField xTextField;
GLabel yLabel;
GTextField yTextField;
GLabel wLabel;
GTextField wTextField;
GLabel hLabel;
GTextField hTextField;

GLabel minRangeLabel;
GTextField minRangeTextField;
GLabel maxRangeLabel;
GTextField maxRangeTextField;


// button states
GLabel state1Label;
GTextField state1TextField;
GLabel state2Label;
GTextField state2TextField;
GLabel state3Label;
GTextField state3TextField;
GLabel state4Label;
GTextField state4TextField;

// text content of label
GLabel labelTextLabel;
GTextField labelTextTextField;



// Graphic frames used to group controls
ArrayList<Rectangle> rects ;

///////////////////// G4P

public void showPropertyPanel(boolean show) {
  btnFolder.setVisible(show);
  btnInput.setVisible(show);
  btnOutput.setVisible(show);
  title.setVisible(show);

  nameLabel.setVisible(show);
  nameTextField.setVisible(show);
  xLabel.setVisible(show);
  xTextField.setVisible(show);
  yLabel.setVisible(show);
  yTextField.setVisible(show);
  wLabel.setVisible(show);
  wTextField.setVisible(show);
  hLabel.setVisible(show);
  hTextField.setVisible(show);
  minRangeLabel.setVisible(show);
  minRangeTextField.setVisible(show);
  maxRangeLabel.setVisible(show);
  maxRangeTextField.setVisible(show);


  state1Label.setVisible(show);
  state1TextField.setVisible(show);
  state2Label.setVisible(show);
  state2TextField.setVisible(show);
  state3Label.setVisible(show);
  state3TextField.setVisible(show);
  state4Label.setVisible(show);
  state4TextField.setVisible(show);

  labelTextLabel.setVisible(show);
  labelTextTextField.setVisible(show);

  /*
   */

  if (show) {
    for (Rectangle r : rects) {
      showFrame(r);
    }
  }
}

public void setCursorOver(int cr) {
  btnFolder.setCursorOver(cr);
  btnInput.setCursorOver(cr);
  btnOutput.setCursorOver(cr);
  title.setCursorOver(cr);

  nameLabel.setCursorOver(cr);
  nameTextField.setCursorOver(cr);
  xLabel.setCursorOver(cr);
  xTextField.setCursorOver(cr);
  yLabel.setCursorOver(cr);
  yTextField.setCursorOver(cr);
  wLabel.setCursorOver(cr);
  wTextField.setCursorOver(cr);
  hLabel.setCursorOver(cr);
  hTextField.setCursorOver(cr);
}



public void createFileSystemGUI(int x, int y, int w, int h, int border) {
  // Store picture frame
  rects.add(new Rectangle(x, y, w, h));

  // Set inner frame position
  x += border; 
  y += border;
  w -= 2*border; 
  h -= 2*border;

  title = new GLabel(this, x, y, w, 20);
  title.setText("Properties", GAlign.LEFT, GAlign.MIDDLE);
  title.setOpaque(true);
  title.setTextBold();

  // Create buttons
  int bgap = 8;
  int bw = round((w - 2 * bgap) / 3.0f);
  int bs = bgap + bw;
  btnFolder = new GButton(this, x, y+30, bw, 20, "Folder");
  btnInput = new GButton(this, x+bs, y+30, bw, 20, "Input");
  btnOutput = new GButton(this, x+2*bs, y+30, bw, 20, "export");

  createPropertyFields(x, y - 120, w);
}


private void createPropertyFields(int x, int y, int w) {  
  // propertyfields
  nameLabel = new GLabel(this, x, y + 170, w, 20);
  nameLabel.setText("Name", GAlign.LEFT, GAlign.MIDDLE);
  nameLabel.setOpaque(true);
  nameLabel.setTextBold();

  nameTextField = new GTextField(this, x, y + 190, w, 20);
  nameTextField.tag = "name tf";
  //nameTextField.setPromptText("Text field 1");

  xLabel = new GLabel(this, x, y +210, w, 20);
  xLabel.setText("x", GAlign.LEFT, GAlign.MIDDLE);
  xLabel.setOpaque(true);
  xLabel.setTextBold();

  xTextField = new GTextField(this, x, y + 230, w, 20);
  xTextField.tag = "x pos tf";
  //xTextField.setPromptText("Text field 1");

  yLabel = new GLabel(this, x, y +250, w, 20);
  yLabel.setText("y", GAlign.LEFT, GAlign.MIDDLE);
  yLabel.setOpaque(true);
  yLabel.setTextBold();

  yTextField = new GTextField(this, x, y + 270, w, 20);
  yTextField.tag = "y pos tf";
  //yTextField.setPromptText("Text field 1");

  wLabel = new GLabel(this, x, y +290, w, 20);
  wLabel.setText("width", GAlign.LEFT, GAlign.MIDDLE);
  wLabel.setOpaque(true);
  wLabel.setTextBold();

  wTextField = new GTextField(this, x, y + 310, w, 20);
  wTextField.tag = "w pos tf";
  //wTextField.setPromptText("Text field 1");

  hLabel = new GLabel(this, x, y +330, w, 20);
  hLabel.setText("height", GAlign.LEFT, GAlign.MIDDLE);
  hLabel.setOpaque(true);
  hLabel.setTextBold();

  hTextField = new GTextField(this, x, y + 350, w, 20);
  hTextField.tag = "h pos tf";
  //hTextField.setPromptText("Text field 1");

  minRangeLabel = new GLabel(this, x, y + 370, w, 20);
  minRangeLabel.setText("min", GAlign.LEFT, GAlign.MIDDLE);
  minRangeLabel.setOpaque(true);
  minRangeLabel.setTextBold();

  minRangeTextField = new GTextField(this, x, y + 390, w, 20);
  minRangeTextField.tag = "min range tf";
  //hTextField.setPromptText("Text field 1");

  maxRangeLabel = new GLabel(this, x, y + 410, w, 20);
  maxRangeLabel.setText("max", GAlign.LEFT, GAlign.MIDDLE);
  maxRangeLabel.setOpaque(true);
  maxRangeLabel.setTextBold();

  maxRangeTextField = new GTextField(this, x, y + 430, w, 20);
  maxRangeTextField.tag = "max range tf";
  //hTextField.setPromptText("Text field 1");


  state1Label = new GLabel(this, x, y + 450, w, 20);
  state1Label.setText("state 1", GAlign.LEFT, GAlign.MIDDLE);
  state1Label.setOpaque(true);
  state1Label.setTextBold();

  state1TextField = new GTextField(this, x, y + 470, w, 20);
  state1TextField.tag = "state 1 tf";
  //hTextField.setPromptText("Text field 1");


  state2Label = new GLabel(this, x, y + 490, w, 20);
  state2Label.setText("state 2", GAlign.LEFT, GAlign.MIDDLE);
  state2Label.setOpaque(true);
  state2Label.setTextBold();

  state2TextField = new GTextField(this, x, y + 510, w, 20);
  state2TextField.tag = "state 2 tf";
  //hTextField.setPromptText("Text field 1");

  state3Label = new GLabel(this, x, y + 530, w, 20);
  state3Label.setText("state 3", GAlign.LEFT, GAlign.MIDDLE);
  state3Label.setOpaque(true);
  state3Label.setTextBold();

  state3TextField = new GTextField(this, x, y + 550, w, 20);
  state3TextField.tag = "state 3 tf";
  //hTextField.setPromptText("Text field 1");

  state4Label = new GLabel(this, x, y + 570, w, 20);
  state4Label.setText("state 4", GAlign.LEFT, GAlign.MIDDLE);
  state4Label.setOpaque(true);
  state4Label.setTextBold();

  state4TextField = new GTextField(this, x, y + 590, w, 20);
  state4TextField.tag = "state 4 tf";
  //hTextField.setPromptText("Text field 1");

  labelTextLabel = new GLabel(this, x, y + 610, w, 20);
  labelTextLabel.setText("Text", GAlign.LEFT, GAlign.MIDDLE);
  labelTextLabel.setOpaque(true);
  labelTextLabel.setTextBold();

  labelTextTextField = new GTextField(this, x, y + 630, w, 20);
  labelTextTextField.tag = "text label tf";
  //hTextField.setPromptText("Text field 1");
}

// Simple graphical frame to group controls
public void showFrame(Rectangle r) {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(color(240, 240, 255));
  rect(r.x, r.y, r.width, r.height);
  //stroke(color(0));
  //rect(r.x+1, r.y+1, r.width, r.height);
  popStyle();
}


// Button Event processing
public void handleButtonEvents(GButton button, GEvent event) { 
  // Folder selection
  if (button == btnFolder || button == btnInput || button == btnOutput)
    displayFileDialog(button);
}

public void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
  displayTextEvent(textControl.tag, event);
}


// G4P code for folder and file dialogs
public void displayFileDialog(GButton button) {
  String fname;
  // Folder selection
  if (button == btnFolder) {
    fname = G4P.selectFolder("Folder Dialog");
  }
  // File input selection
  else if (button == btnInput) {
    // Use file filter if possible
    fname = G4P.selectInput("Input Dialog", "png,gif,jpg,jpeg", "Image files");
  }
  // File output selection
  else if (button == btnOutput) {
    fname = G4P.selectOutput("export to ... ");
  }
}

// display text events

public void displayTextEvent(String name, GEvent event) {
  //print("name: \"" + name + "\"  ");
  switch(event) {
  case ENTERED: 
    {
      println("ENTERED, " +xTextField.getText());
      xTextField.setFocus(false);
      break;
    }
  default:
    break;
  }
}



// set value of fields

void setFields(Drawable d) {
  if (d != null) {

    // name, position and dimensions
    nameTextField.setText(d.getName());
    xTextField.setText(d.getAbsoluteX() + "");
    yTextField.setText(d.getAbsoluteY() + "");
    wTextField.setText(d.getWidth() + "");
    hTextField.setText(d.getHeight() + "");

    // min max of slider
    minRangeTextField.setText(d.getMinRange() + "");
    maxRangeTextField.setText(d.getMaxRange() + "");

    // possible state of a button, default is four 
    state1TextField.setText(d.getState("state1") + "");
    state2TextField.setText(d.getState("state2") + "");
    state3TextField.setText(d.getState("state3") + "");
    state4TextField.setText(d.getState("state4") + "");

    // label text
    labelTextTextField.setText(d.getLabelText() + "");
  }
}