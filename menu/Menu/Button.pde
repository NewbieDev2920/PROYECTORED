class Button {
  PVector position = new PVector();
  PVector scale = new PVector();
  String dir;
  String text;
  PVector textPos = new PVector();

  Button(float x, float y, float w, float h, String dir) {
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
    this.dir = dir;
    textPos.x = position.x + 5;
    textPos.y = position.y + scale.y/2;
  }

  boolean clicked() {
    if (hovered()) {
      hoverEffect();
      if (mousePressed) {
        return true;
      }
    }
    return false;
  }
  
  boolean hovered() {
    return mouseX > position.x && mouseX < position.x + scale.x && mouseY > position.y && mouseY < position.y + scale.y;
  }
  
  void hoverEffect() {
    fill(255, 255, 0); // Change the color when hovered
  }
  
  void display() {
    if (hovered()) {
      hoverEffect();
    } else {
      fill(255, 0, 0);
    }
    //rect(position.x, position.y, scale.x, scale.y);
    fill(0);
    //text(text, textPos.x, textPos.y);
  }
}
