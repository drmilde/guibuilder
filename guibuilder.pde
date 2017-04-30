import java.awt.Rectangle;
import g4p_controls.*;

int ursprung_x = 80;
int ursprung_y = 60;
int gridSize = 20;

ItemManager items = new ItemManager();
ItemManager catalog = new ItemManager();

int cx = 0, cy = 0; // click coordinates
int ox = 0, oy = 0; // last click, cursor coords
int rx = 0, ry = 0; // grab mouse pos, used for relative movement
int state = 0; // neutral state

// box select
int minBoxX, minBoxY, maxBoxX, maxBoxY;

// selectAll
boolean selectAll = false;


// toggle properties
boolean propertyPanel = false;



// detect ctrl key
boolean ctrlPressed = false;
char ctrlKey = ' ';

// detect shift key
boolean shiftPressed = false;

void setup() {
  size(1094, 600);

  // aufbau catalog
  catalog.add(new KnobDrawable(10, ursprung_y + 10, 60, 60, 0, 0));
  catalog.add(new ButtonDrawable(10, ursprung_y + 80, 60, 60, 0, 0));
  catalog.add(new LabelDrawable("label", 10, ursprung_y + 150, 60, 60, 0, 0));
  catalog.add(new HSliderDrawable(10, ursprung_y + 220, 60, 60, 0, 0));
  catalog.add(new VSliderDrawable(10, ursprung_y + 290, 60, 60, 0, 0));

  // controls in G4P

  rects = new ArrayList<Rectangle> ();
  int nwdth = 200;
  createFileSystemGUI(width- nwdth - 2, ursprung_y, 
    nwdth, height - 2 - ursprung_y, 6);
}


void draw() {
  background(127);

  drawLines();

  // raster
  pushMatrix();
  translate(ursprung_x, ursprung_y);
  for (int i = 0; i < (width / gridSize) + 1; i++) {
    for (int j = 0; j < (width / gridSize) + 1; j++) {
      pushStyle();
      fill(#111111);
      noStroke();
      ellipse(i*gridSize, j*gridSize, 2, 2);
      popStyle();
    }
  }
  popMatrix();

  // update 
  update();

  // draw content
  catalog.draw();
  items.draw();
  drawCursor();
  text("state: " + state, width -100, 30);

  if (state == 10) { // mouse dragging
    pushStyle();
    noFill();
    stroke(#ffffff);
    rect ( minBoxX, minBoxY, (maxBoxX - minBoxX), (maxBoxY - minBoxY) );     
    popStyle();
  }

  // g4P

  showPropertyPanel();
}

void drawLines() {
  // lines
  pushStyle();
  stroke(#ffffff);
  strokeWeight(3);
  line (0, ursprung_y, width, ursprung_y);
  line (ursprung_x, 0, ursprung_x, height);
  popStyle();
}

void drawCursor() {
  if (cx > ursprung_x) { // into working area
    ox = cx;
    oy = cy;

    pushStyle();

    noStroke();
    fill(#ffffff);
    ellipse(ox, oy, 5, 5);

    noFill();
    stroke(#0000ff);
    strokeWeight(2);
    ellipse(ox, oy, 11, 11);

    popStyle();
  }
}

void update() {
  if (state == 0) { // mouse moving state (default)

    rx = mouseX; // save current mouse position for relative move
    ry = mouseY;

    cursor(ARROW); // reset cursor to arrow
  }


  if (state == 1) { // mouse has been clicked, slect item(s)
    if (cx > ursprung_x) { // into working area

      if (ctrlPressed) { // ctrl click for mutliple selects
        items.select(cx, cy, true);
      } else {
        items.select(cx, cy, false);
      }

      items.updateAbsolutePos(gridSize);
      setFields(); // update property panel
    }

    if (cx < ursprung_x) { // into catalog
      catalog.select(cx, cy, false);
    }

    state = 0;
  }

  if (state == 2) { // grab and move the item    
    items.setRelativePos(mouseX - rx, mouseY - ry, gridSize);
  }

  if (state == 4) { // clone and add the item from catalog to items
    if (cx > ursprung_x) {
      Drawable d = catalog.cloneSelected();
      if (d != null) {
        d.setAbsolutePos(cx, cy, gridSize);
        items.add(d);
      }
    }
    state = 0;
  }


  if (state == 5) { // remove selected item
    if (cx > ursprung_x) {
      items.removeSelected();
    }
    state = 0;
  }


  if (state == 6) { // duplicate selected item
    if (cx > ursprung_x) {
      items.duplicateSelected(gridSize*3, gridSize*3, gridSize);
    }
    state = 0; // duplicated items are selected
  }

  if (state == 7) { // export to xml
    println (items.toXML());
    state = 0;
  }

  if (state == 8) { // save to bytes
    items.save();
    state = 0;
  }

  if (state == 9) { // box select
    cursor(CROSS); // set cursor to cross
    minBoxX = mouseX;
    minBoxY = mouseY;
    maxBoxX = mouseX;
    maxBoxY = mouseY;
  }

  if (state == 10) { //dragging mode
    maxBoxX = mouseX;
    maxBoxY = mouseY;
  }

  if (state == 11) { //mouse released after dragging
    int minx = min(minBoxX, maxBoxX);
    int maxx = max(minBoxX, maxBoxX);

    int miny = min(minBoxY, maxBoxY);
    int maxy = max(minBoxY, maxBoxY);

    items.boxSelect ( minx, miny, (maxx - minx), (maxy - miny) );     
    state = 0;
  }

  if (state == 12) { //dragging mode
    selectAll = !selectAll;
    items.selectAll(selectAll);
    state = 0;
  }

  if (state == 13) { //toggle property panel
    propertyPanel = !propertyPanel;
    setFields();
    state = 0;
  }


  if (state == 99) { // clear items
    items.clear();
    state = 0;
  }
  if (state == 100) { // increase width
    items.increaseWidth(20, gridSize);
    state = 0;
  }
  if (state == 101) { // decrease width
    items.increaseWidth(-20, gridSize);
    state = 0;
  }
}


// user interface
void mouseClicked() {
  // save mouse click pos
  cx = mouseX;
  cy = mouseY;

  state = 1; // mouse has been clicked
}


void keyReleased() {
  // has control been released ??
  if (keyCode != CONTROL) {
    // noe, andere Taste released
  } else {
    ctrlPressed = false;
  }

  // has shift been released ??
  if (keyCode != SHIFT) {
    // noe, andere Taste released
  } else {
    shiftPressed = false;
  }


  // processing ctrl keys
  if (ctrlPressed) {
    switch (ctrlKey) {
    case 'n' : 
      {
        state = 99; // clear state with ctrl+n
        break;
      }
    }
  }

  // standard key processing
  switch (key) {
  case 'g' : 
    {
      state = 2; // grab state
      break;
    }
  case 's' : 
    {
      state = 3; // scale state
      break;
    }
  case 'A' : 
    {
      state = 4; // add state
      break;
    }
  case 'x' : 
    {
      state = 5; // remove state
      break;
    }
  case 'D' : 
    {
      state = 6; // duplicate selected
      break;
    }

  case 'P' : 
    {
      state = 7; // export to XML selected
      break;
    }
  case 'O' : 
    {
      state = 8; //save to bytes selected
      break;
    }
  case 'b' : 
    {
      state = 9; // box select selected
      break;
    }
  case 'a' : 
    {
      state = 12; // toggle select all
      break;
    }

  case 'n': 
    {
      state = 13; // toggle 
      break;
    }

  case '+' : 
    {
      state = 100; // increase width
      break;
    }
  case '-' : 
    {
      state = 101; // decrease width
      break;
    }
  }
}

void mouseDragged() {
  if (state == 9) { // starting box select mode
    state = 10; // now in dragging mode
  }

  if (state == 10) { // in mouse dragging mode
    maxBoxX = mouseX;
    maxBoxY = mouseY;
  }
}

void mouseReleased() {
  if (state == 10) { // in mouse dragging mode
    state = 11; // end mouse dragging
  }
}

public void keyPressed() {
  // react to ctrl + key
  if ((keyCode == CONTROL) && (!ctrlPressed)) {
    ctrlPressed = true;
  }

  // process shift key for shift+click
  if ((keyCode == SHIFT) && (!shiftPressed)) {
    shiftPressed = true;
  }

  // set the control key
  if (ctrlPressed) {
    if (char(keyCode) == 'N') {
      ctrlKey = 'n';
    }
  }
}


///////////////////// G4P

public void showPropertyPanel() {
  btnFolder.setVisible(propertyPanel);
  btnInput.setVisible(propertyPanel);
  btnOutput.setVisible(propertyPanel);
  lblFile.setVisible(propertyPanel);
  title.setVisible(propertyPanel);
  txf1.setVisible(propertyPanel);

  nameLabel.setVisible(propertyPanel);
  nameTextField.setVisible(propertyPanel);
  xLabel.setVisible(propertyPanel);
  xTextField.setVisible(propertyPanel);
  yLabel.setVisible(propertyPanel);
  yTextField.setVisible(propertyPanel);
  wLabel.setVisible(propertyPanel);
  wTextField.setVisible(propertyPanel);
  hLabel.setVisible(propertyPanel);
  hTextField.setVisible(propertyPanel);

  if (propertyPanel) {
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
    handleFileDialog(button);
}


// G4P code for folder and file dialogs
public void handleFileDialog(GButton button) {
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

// handle text events

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

public void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
  displayEvent(textControl.tag, event);
}


// set value of fields

void setFields() {
  Drawable d = items.getFirstSelected();
  if (d != null) {
    nameTextField.setText(d.getName());
    /*
  xTextField.setVisible(propertyPanel);
     yTextField.setVisible(propertyPanel);
     wTextField.setVisible(propertyPanel);
     hTextField.setVisible(propertyPanel);
     */
  }
}


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