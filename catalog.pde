public void createCatalog(int px, int py) {
  // aufbau catalog
  String[] knobHeaders  = {"Name", "x", "y", "width", "height"};
  KnobDrawable kd = new KnobDrawable(px, 
    ursprung_y + py, 
    catalogSize, catalogSize, 0, 0, knobHeaders);
  catalog.add(kd);

  String[] labelHeaders  = {"Name", "x", "y", "width", "height", "Text"};
  LabelDrawable ld = new LabelDrawable("label", px, 
    ursprung_y + py + (catalogSize+10) * 1, 
    catalogSize, catalogSize, 0, 0, labelHeaders); 
  catalog.add(ld);

  String[] vsliderHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  VSliderDrawable vsd = new VSliderDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 2, 
    catalogSize, catalogSize, 0, 0, vsliderHeaders);
  catalog.add(vsd);

  String[] textFieldHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  TextFieldDrawable tfd = new TextFieldDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 3, 
    catalogSize, catalogSize, 0, 0, textFieldHeaders);
  catalog.add(tfd);

  String[] multiTextHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  MultiTextDrawable mtd = new MultiTextDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 4, 
    catalogSize, catalogSize, 0, 0, multiTextHeaders);
  catalog.add(mtd);

  String[] groupHeaders  = {"Name", "x", "y", "width", "height"};
  GroupDrawable grd = new GroupDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 5, 
    catalogSize, catalogSize, 0, 0, groupHeaders);
  catalog.add(grd);

  String[] hrangeSliderHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  HRangeSliderDrawable hrsd = new HRangeSliderDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 6, 
    catalogSize, catalogSize, 0, 0, hrangeSliderHeaders);
  catalog.add(hrsd);

  secondColumn(px + 60, py);
}


public void secondColumn(int px, int py) {

  String[] buttonHeaders  = {"Name", "x", "y", "width", "height", "state 1", "state 2", "state 3", "state 4" };
  ButtonDrawable bd = new ButtonDrawable(px, 
    ursprung_y + py + (catalogSize+10) * 0, 
    catalogSize, catalogSize, 0, 0, buttonHeaders);   
  catalog.add(bd);

  String[] hsliderHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  HSliderDrawable hsd = new HSliderDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 1, 
    catalogSize, catalogSize, 0, 0, hsliderHeaders);
  catalog.add(hsd);

  String[] slider2DHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  Slider2DDrawable s2dd = new Slider2DDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 2, 
    catalogSize, catalogSize, 0, 0, slider2DHeaders);
  catalog.add(s2dd);

  String[] multiSliderHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  MultiSliderDrawable msd = new MultiSliderDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 3, 
    catalogSize, catalogSize, 0, 0, multiSliderHeaders);
  catalog.add(msd);

  String[] flowLayoutHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  FlowLayoutDrawable fld = new FlowLayoutDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 4, 
    catalogSize, catalogSize, 0, 0, flowLayoutHeaders);
  catalog.add(fld);


  String[] vrangeSliderHeaders  = {"Name", "x", "y", "width", "height", "min", "max"};
  VRangeSliderDrawable vrsd = new VRangeSliderDrawable(px, 
    ursprung_y + py + (catalogSize + 10) * 5, 
    catalogSize, catalogSize, 0, 0, vrangeSliderHeaders);
  catalog.add(vrsd);
}