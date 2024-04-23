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
  
  void display(){
   fill(255,0,0);
   rect(position.x, position.y, scale.x, scale.y);
   fill(0);
   text(text, textPos.x, textPos.y);
  }
}
