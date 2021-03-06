import java.awt.Rectangle;
import g4p_controls.*;

int ursprung_x = 120;
int ursprung_y = 60;
int gridSize = 20;
int catalogSize = 2 * gridSize;

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
int nwdth = 200;

// detect ctrl key
boolean ctrlPressed = false;
char ctrlKey = ' ';

// detect shift key
boolean shiftPressed = false;

// scale axis
boolean xAxisScale = true;
boolean yAxisScale = true;

// instance of property panel
PropertyPanel panel;

void setup() {
  size(1094, 700);


  // create catalog
  createCatalog(10, -20);

  // controls in G4P
  G4P.setGlobalColorScheme(5);
  G4P.setMouseOverEnabled(false);

  createToolBar(ursprung_x + 20, 10, 200, 40);

  // PropertyPanel
  panel = new PropertyPanel(this, width-200-8, ursprung_y+8, 200, 20, "Properties");
  String[] headers  = { "Name", "x", "y", "width", "height"};
  panel.setHeaders(headers);
}


void draw() {
  background(127);

  // static draw into background
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

  catalog.draw();

  /// END static draw

  // update 
  update();

  // Dynamic draw content
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
  panel.show(propertyPanel);
}

void drawLines() {
  // lines
  pushStyle();
  stroke(#ffffff);
  strokeWeight(3);
  line (ursprung_x, ursprung_y, width, ursprung_y);
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

    if (mouseX < ursprung_x) {
      String tt = catalog.getTooltip(mouseX, mouseY);
      if (tt != "") {
        pushStyle();
        fill(#ffffff);
        rect(mouseX, mouseY, 90, 20);
        fill(#000000);    
        text (tt, mouseX+20, mouseY+15);
        popStyle();
      }
    }

    cursor(ARROW); // reset cursor to arrow

    // adjust size to grid
    items.updateSize(gridSize);

    // reset scale axis
    xAxisScale = true;
    yAxisScale = true;
  }

  if (state == 1) { // mouse has been clicked, select item(s)

    if ((propertyPanel) && (cx > (width - nwdth))) {
      println ("click into property panel");
    } else {
      if ((cx > ursprung_x)  && (cy > ursprung_y)) { // into working area

        if (ctrlPressed) { // ctrl click for mutliple selects
          items.select(cx, cy, true);
        } else {
          items.select(cx, cy, false);
        }

        items.updateAbsolutePos(gridSize);

        // update property panel
        updatePropertyPanel();
      }

      if (cx < ursprung_x) { // into catalog
        catalog.select(cx, cy, false);
      }
    }

    state = 0;
  }

  if (state == 2) { // grab and move the item    
    items.setRelativePos(mouseX - rx, mouseY - ry, gridSize);
    // update property panel
    updatePropertyPanel();
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
      items.duplicateSelected(gridSize*2, gridSize*2, gridSize);
    }

    // update property panel
    updatePropertyPanel();

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

    items.boxSelect ( minx, miny, (maxx - minx), (maxy - miny), true );     
    state = 0;
  }

  if (state == 12) { //dragging mode
    selectAll = !selectAll;
    items.selectAll(selectAll);
    updatePropertyPanel();
    state = 0;
  }

  if (state == 13) { //toggle property panel
    propertyPanel = !propertyPanel;
    // update property panel
    updatePropertyPanel();
    state = 0;
  }

  if (state == 90) { // esc pressed
    items.unSelectAll();
    selectAll = false;
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
  // keys are processed by the property panel
  if (panel.hasFocus()) {
    return;
  }

  // has control key been released ??
  if (keyCode != CONTROL) {
    // noe, andere Taste released
  } else {
    ctrlPressed = false;
  }

  // has shift key been released ??
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
      state = 3; // nonlinear scale state
      break;
    }

  case 'S' : 
    {
      state = 33; // linear scale state
      break;
    }

  case 'A' : 
    {
      state = 4; // add state
      break;
    }

  case 'x' : 
    {
      if (state == 3) { // scale mode x-axis
        yAxisScale = false;
      } else {
        state = 5; // remove state
      }
      break;
    }
  case 'y' : 
    {
      if (state == 3) { // scale mode y-axis
        xAxisScale = false; // remove state
      }
      break;
    }

  case 'D' : 
    {
      state = 6; // duplicate selected
      break;
    }

  case 'P' : 
    {
      state = 7; // print XML selected
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
      state = 13; // toggle property panel
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

void mouseMoved() {
  int deltaX = (mouseX - pmouseX);
  int deltaY = (mouseY - pmouseY);

  if (state == 3) { // moving mouse to scale, nonlinear
    if (xAxisScale) {
      items.setWidthDelta(gridSize*2, deltaX, gridSize);
    }
    if (yAxisScale) {
      items.setHeightDelta(gridSize*2, deltaY, gridSize);
    }
  }

  if (state == 33) { // linear scaling
    items.setWidthDelta(gridSize*2, deltaX, gridSize);
    items.setHeightDelta(gridSize*2, deltaX, gridSize);
  }

  // update property panel
  updatePropertyPanel();
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
  // catch ESC ??
  if (keyCode == ESC) {
    key = 0;
    state = 90; // unselect all
  }  

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

// export to xml
public void exportXML(String fname) {
  XML xml = parseXML(items.toXML());

  if (xml == null) {
    println("XML could not be parsed.");
  } else {
    saveXML(xml, fname);
  }
}

// property panel update
public void updatePropertyPanel() {
  Drawable d = items.getFirstSelected();
  if (d != null) {
    panel.setHeaders(d.getHeaders());
    panel.setFields(d);
  } else {
    panel.clearFields();
  }
}

public void storeSProperty(String att, String val) {
  Drawable d = items.getFirstSelected();
  if (d != null) {
    d.putSProperty(att, val);
  }
}