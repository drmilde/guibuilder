public class PropertyManager {
  HashMap<String, Property> properties = new HashMap<String, Property>();

  public PropertyManager() {
    properties = new HashMap<String, Property>();
  }
  
  public void put(String s, Property p) {
    properties.put(s,p);
  }
  
  public Property get(String s) {
    return(properties.get(s));
  }
}



/////////////////// Property
public class Property {
  private String attName = "";
  private int ID = -1;

  private int iValue = 0;
  private float fValue = 0;
  private String sValue = "";


  public Property (String name, int v) {
    attName = name;
    iValue = v;
    ID = 0;
  }

  public Property (String name, float v) {
    attName = name;
    fValue = v;
    ID = 1;
  }

  public Property (String name, String v) {
    attName = name;
    sValue = v;
    ID = 2;
  }

  public int getIValue() {
    if (ID == 0) {
      return iValue;
    } else {
      return 0;
    }
  }

  public float getFValue() {
    if (ID == 1) {
      return fValue;
    } else {
      return 0;
    }
  }

  public String getSValue() {
    if (ID == 2) {
      return sValue;
    } else {
      return "";
    }
  }


  // setter

  public void setIValue(int v) {
    if (ID == 0) {
      iValue = v;
    }
  }
  public void setFValue(float v) {
    if (ID == 1) {
      fValue = v;
    }
  }
  public void setSValue(String v) {
    if (ID == 2) {
      sValue = v;
    }
  }
}