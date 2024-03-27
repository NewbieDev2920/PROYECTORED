class Debug {
  boolean enabled = false;
  //topRight, topLeft, bottomLeft, bottomRight
  String position;
  PVector pos = new PVector();
  PVector scale = new PVector();
  public ArrayList<String> msgList = new ArrayList<String>();
  float gap = 40;


  Debug(String position, float w, float h) {
    this.position = position;
    this.scale.x = w;
    this.scale.y = h;
  }

  void init() {
    if (enabled) {
      println("Debug.enabled = true");
      textSize(16);
      if (position == "topRight") {
        pos.x = width-scale.x;
        pos.y = 0;
      } else if (position == "topLeft") {
        pos.x = 0;
        pos.y = 0;
      } else if (position == "bottomLeft") {
        pos.x = 0;
        pos.y = height-scale.y;
      } else if (position == "bottomRight") {
        pos.x = width-scale.x;
        pos.y = height-scale.y;
      } else {
        print("Error, unknown position for: "+ position);
      }
    } else {
      println("Debug.enabled = false");
    }
  }

  void display() {
    if (enabled) {
      fill(0,0,0, 127);
      rect(pos.x, pos.y, scale.x, scale.y);
      for (int i = 0; i < msgList.size(); i++) {
        fill(12, 250, 12);
        text(msgList.get(i), pos.x+8, pos.y+gap*(i+1));
      }
    }
  }
}
