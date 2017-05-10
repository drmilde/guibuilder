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
  
  public static final int INT = 0;
  public static final int FLOAT = 1;
  public static final int STRING = 2;

  public Property (String name, int v) {
    attName = name;
    iValue = v;
    ID = INT;
  }

  public Property (String name, float v) {
    attName = name;
    fValue = v;
    ID = FLOAT;
  }

  public Property (String name, String v) {
    attName = name;
    sValue = v;
    ID = STRING;
  }

  public int getIValue() {
    if (ID == INT) {
      return iValue;
    } else {
      return 0;
    }
  }

  public float getFValue() {
    if (ID == FLOAT) {
      return fValue;
    } else {
      return 0;
    }
  }

  public String getSValue() {
    if (ID == STRING) {
      return sValue;
    } else {
      return "";
    }
  }
  
  public int getID() {
    return ID;
  }


  // setter

  public void setIValue(int v) {
    if (ID == INT) {
      iValue = v;
    }
  }
  public void setFValue(float v) {
    if (ID == FLOAT) {
      fValue = v;
    }
  }
  public void setSValue(String v) {
    if (ID == STRING) {
      sValue = v;
    }
  }
}