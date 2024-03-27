class Button {
  PVector position = new PVector();
  PVector scale = new PVector();
  String type;

  Button(float x, float y, float w, float h, String type) {
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
    this.type = type;
  }

  boolean clicked() {
    if(mouseX > position.x && mouseX < position.x + scale.x && mouseY > position.y && mouseY < position.y + scale.y){
      hoverEffect();
      if(mousePressed){
        return true;  
      }
      return false;
    }
    else{
      return false; 
    }
  }
  
  void hoverEffect(){
    
  }
}
