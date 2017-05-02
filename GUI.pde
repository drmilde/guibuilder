// Controls used for file dialog GUI 
GLabel title;
GButton btnFolder, btnInput, btnOutput;
GLabel lblFile;

// Textfeld
GTextField txf1;

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

// Graphic frames used to group controls
ArrayList<Rectangle> rects ;


///////////////////// G4P

public void showPropertyPanel(boolean show) {
  btnFolder.setVisible(show);
  btnInput.setVisible(show);
  btnOutput.setVisible(show);
  lblFile.setVisible(show);
  title.setVisible(show);
  txf1.setVisible(show);

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

  if (show) {
    for (Rectangle r : rects) {
      showFrame(r);
    }
  }
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
  title.setText("File system dialogs", GAlign.LEFT, GAlign.MIDDLE);
  title.setOpaque(true);
  title.setTextBold();

  // Create buttons
  int bgap = 8;
  int bw = round((w - 2 * bgap) / 3.0f);
  int bs = bgap + bw;
  btnFolder = new GButton(this, x, y+30, bw, 20, "Folder");
  btnInput = new GButton(this, x+bs, y+30, bw, 20, "Input");
  btnOutput = new GButton(this, x+2*bs, y+30, bw, 20, "Output");

  lblFile = new GLabel(this, x, y+60, w, 60);
  lblFile.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblFile.setOpaque(true);
  lblFile.setLocalColorScheme(G4P.GREEN_SCHEME);


  /// Textfield
  txf1 = new GTextField(this, x, y + 130, w, 20);
  txf1.tag = "txf1 - juppie duh";
  txf1.setPromptText("Text field 1");

  // propertyfields
  nameLabel = new GLabel(this, x, y +170, w, 20);
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
  displayEvent(textControl.tag, event);
}


// G4P code for folder and file dialogs
public void displayFileDialog(GButton button) {
  String fname;
  // Folder selection
  if (button == btnFolder) {
    fname = G4P.selectFolder("Folder Dialog");
    lblFile.setText(fname);
  }
  // File input selection
  else if (button == btnInput) {
    // Use file filter if possible
    fname = G4P.selectInput("Input Dialog", "png,gif,jpg,jpeg", "Image files");
    lblFile.setText(fname);
  }
  // File output selection
  else if (button == btnOutput) {
    fname = G4P.selectOutput("Output Dialog");
    lblFile.setText(fname);
  }
}

// display text events

public void displayEvent(String name, GEvent event) {
  //print("name: \"" + name + "\"  ");
  switch(event) {
  case ENTERED: 
    {
      println("ENTERED, " +txf1.getText());
      txf1.setFocus(false);
      break;
    }
  default:
    break;
  }
}



// set value of fields

void setFields(Drawable d) {
  if (d != null) {
    nameTextField.setText(d.getName());
    xTextField.setText(d.getAbsoluteX() + "");
    yTextField.setText(d.getAbsoluteY() + "");
    wTextField.setText(d.getWidth() + "");
    hTextField.setText(d.getHeight() + "");
    /*
     */
  }
}