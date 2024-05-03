class particle{
  Sprite sprite = new Sprite();
  PVector position = new PVector();
  
  void init(String path){

  }
  
  void display(PVector pos, int interval){
      fill(200,0,0);
      ellipse(pos.x, pos.y, 2,2);
  }
}
