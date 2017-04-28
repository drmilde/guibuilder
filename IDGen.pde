public static class IDGen {
  private static int ID = 0;
  
  public IDGen() {
    reset();
  }
  
  public static void reset() {
    ID = 0;
  }
  
  public static int next() {
    return ID++;
  }
}