// Controls used for file dialog GUI 
GButton btnExit, btnInput, btnOutput;
GButton btnHorizontal, btnVertical; 
GButton spreadHorizontal, spreadVertical; 
GButton unspreadHorizontal, unspreadVertical; 

///////////////////// G4P
public void createToolBar(int x, int y, int w, int h) {
  // Create buttons
  int bgap = 8;
  int bw = round((w - 2 * bgap) / 3.0f);
  int bs = bgap + bw;

  btnExit = new GButton(this, x, y, bw, h, "Exit");
  btnInput = new GButton(this, x+bs, y, bw, h, "Open");
  btnOutput = new GButton(this, x+2*bs, y, bw, h, "Export");
  btnHorizontal = new GButton(this, x+3*bs, y, bw, h, "Horizontal");
  btnVertical = new GButton(this, x+4*bs, y, bw, h, "Vertical");
  spreadHorizontal = new GButton(this, x+5*bs, y, bw, h, "[h +]");
  unspreadHorizontal = new GButton(this, x+6*bs, y, bw, h, "[h -]");
  spreadVertical = new GButton(this, x+7*bs, y, bw, h, "[v +]");
  unspreadVertical = new GButton(this, x+8*bs, y, bw, h, "[v -]");
}


// Button Event processing
public void handleButtonEvents(GButton button, GEvent event) { 
  // Button selection
  dispatchButtons(button);
}

// G4P code for folder and file dialogs
public void dispatchButtons(GButton button) {
  String fname;

  // exit application
  if (button == btnExit) {
    println ("exit");

    int result = G4P.selectOption(this, "Exit application? (work is NOT saved)", "Bye Bye", 
      G4P.QUERY, G4P.YES_NO);

    if (result == G4P.OK) {
      exit();
    }
  }
  // File input selection
  else if (button == btnInput) {
    fname = G4P.selectInput("Open file");
  }
  // File output selection
  else if (button == btnOutput) {

    fname = G4P.selectOutput("Export to ...");
    if (fname != null) {
      exportXML(fname);
    } else {
      println ("file name is empty");
    }
  }
  // horizontal align selection
  else if (button == btnHorizontal) {
    println("HORIZONTAL ...");
    items.alignHorizontal(gridSize);
  }
  // vertical align selection
  else if (button == btnVertical) {
    println("VERTICAL ...");
    items.alignVertical(gridSize);
  }
  // spread horizontal selection
  else if (button == spreadHorizontal) {
    println("spread HORIZONTAL ...");
    items.spreadHorizontal(gridSize, gridSize);
  }
  // spread vertical selection
  else if (button == spreadVertical) {
    println("spread VERTICAL ...");
    items.spreadVertical(gridSize, gridSize);
  }
  // unspread horizontal selection
  else if (button == unspreadHorizontal) {
    println("unspread HORIZONTAL ...");
    items.spreadHorizontal(-gridSize, gridSize);
  }
  // unspread vertical selection
  else if (button == unspreadVertical) {
    println("unspread VERTICAL ...");
    items.spreadVertical(-gridSize, gridSize);
  }
}


public void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
  displayTextEvent(textControl.tag, event);
}

// display text events
public void displayTextEvent(String name, GEvent event) {
  switch(event) {
  case ENTERED: 
    {
      println ("processing data");
      processData(name, panel.getField(name));
      break;
    }
  default:
    break;
  }
}

private void processData (String att, String val) {
  // transmit data to slected Drawable
  Drawable d = items.getFirstSelected();
  if (d != null) {
    d.processData(att,val);
  }
}